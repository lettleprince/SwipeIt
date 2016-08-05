//
//  RxSwift+Helpers.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

/**
 Helpful function to be able to abstract observable sequences into void.
 e.g. Observable.just(something).map(void)

 - parameter _: _ anything is turned into void

 */
func void<T>(_: T) -> Void {
  return Void()
}
