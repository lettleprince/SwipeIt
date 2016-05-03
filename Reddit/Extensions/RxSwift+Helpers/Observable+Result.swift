//
//  Observable+Result.swift
//  Reddit
//
//  Created by Ivan Bruel on 03/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import Result

extension ObservableType where E: ResultType {

  func doOnSuccess(onSuccess: (E.Value throws -> Void))
    -> Observable<E> {
      return self.doOnNext { (value) in
        guard let successValue = value.value else {
          return
        }
        try onSuccess(successValue)
      }
  }

  func doOnFailure(onFailure: (E.Error throws -> Void))
    -> Observable<E> {
      return self.doOnNext { (value) in
        guard let failureValue = value.error else {
          return
        }
        try onFailure(failureValue)
      }
  }

}
