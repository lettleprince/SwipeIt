//
//  AlerteableViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift

protocol AlerteableViewController {

  func presentAlert(title: String?,
                    message: String?,
                    textField: AlertTextField?,
                    buttonTitle: String?,
                    cancelButtonTitle: String?) -> Observable<AlertButtonClicked>

}

extension AlerteableViewController where Self: UIViewController {

  func presentAlert(title: String? = nil,
                    message: String? = nil,
                    textField: AlertTextField? = nil,
                    buttonTitle: String? = nil,
                    cancelButtonTitle: String? = nil) -> Observable<AlertButtonClicked> {

    return Observable.create { [weak self] observable in

      let alertController = UIAlertController(title: title, message: message,
        preferredStyle: .Alert)

      if let cancelButtonTitle = cancelButtonTitle {
        let dismissAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel) { _ in
          observable.onNext(.Cancel)
          observable.onCompleted()
        }
        alertController.addAction(dismissAction)
      }

      if let textFieldConfig = textField {
        alertController.addTextFieldWithConfigurationHandler { (textField) in
          textField.placeholder = textFieldConfig.placeholder
          textField.text = textFieldConfig.text

          if let buttonTitle = buttonTitle {
            let buttonAction = UIAlertAction(title: buttonTitle, style: .Default) { _ in
              observable.onNext(.ButtonWithText(textField.text))
              observable.onCompleted()
            }
            alertController.addAction(buttonAction)
          }
        }
      } else {
        if let buttonTitle = buttonTitle {
          let buttonAction = UIAlertAction(title: buttonTitle, style: .Default) { _ in
            observable.onNext(.Button)
            observable.onCompleted()
          }
          alertController.addAction(buttonAction)
        }
      }
      self?.presentViewController(alertController, animated: true, completion: nil)

      return AnonymousDisposable {
        alertController.dismissViewControllerAnimated(true, completion: nil)
      }
    }.take(1)
  }
}

enum AlertButtonClicked {
  case Button
  case ButtonWithText(String?)
  case Cancel
}

func == (lhs: AlertButtonClicked, rhs: AlertButtonClicked) -> Bool {
  switch (lhs, rhs) {
  case (.Button, .Button):
    return true
  case (.ButtonWithText, .ButtonWithText):
    return true
  case (.Cancel, .Cancel):
    return true
  default:
    return false
  }
}

struct AlertTextField {
  let text: String?
  let placeholder: String?

  init(text: String?, placeholder: String?) {
    self.text = text
    self.placeholder = placeholder
  }
}
