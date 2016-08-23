//
//  WebViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import WebKit

// MARK: Properties, Lifecycle and API
class WebViewController: UIViewController {

  let webView = WKWebView()
  let progressView: UIProgressView = UIProgressView(progressViewStyle: .Bar)


  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
  }

  func loadURL(URLString: String) {
    guard let url = NSURL(string: URLString) else {
      print("\(URLString) is not a valid URL string")
      return
    }
    webView.loadRequest(NSURLRequest(URL: url))
  }
}

//MARK: Setup
extension WebViewController: WKNavigationDelegate {

  private func setupViews() {
    setupWebView()
    setupProgressView()
  }

  private func setupWebView() {
    webView.navigationDelegate = self
    view.addSubview(webView)
    webView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(view)
    }
  }

  private func setupProgressView() {
    view.addSubview(progressView)

    progressView.snp_makeConstraints { (make) in
      make.top.equalTo(self.snp_topLayoutGuideBottom)
      make.left.right.equalTo(view)
    }

    webView.rx_observe(Double.self, "estimatedProgress")
      .bindNext { estimatedProgress in
        guard let estimatedProgress = estimatedProgress else {
          return
        }
        self.progressView.layer.removeAllAnimations()
        let floatEstimatedProgress = Float(estimatedProgress)
        let animateChange = self.progressView.progress < floatEstimatedProgress
        self.progressView.setProgress(floatEstimatedProgress, animated: animateChange)
        if estimatedProgress == 1 {
          self.hideProgressView()
        } else {
          self.progressView.alpha = 1
        }
      }.addDisposableTo(rx_disposeBag)
  }
}

// MARK: Animations
extension WebViewController {

  private func hideProgressView() {
    UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: {
      self.progressView.alpha = 0
    }) { _ in
      self.progressView.progress = 0
    }
  }
}
