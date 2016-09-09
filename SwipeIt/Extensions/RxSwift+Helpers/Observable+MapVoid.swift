//
//  RxSwift+Helpers.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {

  /**
   Helpful function to be able to abstract observable sequences into void.
   e.g. Observable.just(something).mapVoid()

   - returns: anything is turned into void
   */
  func mapVoid() -> Observable<Void> {
    return map { _ in Void() }
  }
}
