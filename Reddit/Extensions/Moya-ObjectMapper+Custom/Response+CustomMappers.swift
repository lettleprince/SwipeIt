//
//  Response+CustomMappers.swift
//  Reddit
//
//  Created by Ivan Bruel on 28/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

extension Response {

  public func mapPair<T: Mappable, U: Mappable>() throws -> (T, U) {
    guard let jsonArray = try mapJSON() as? [AnyObject] where jsonArray.count == 2 else {
      throw Error.JSONMapping(self)
    }
    guard let firstObject = Mapper<T>().map(jsonArray[0]),
      secondObject = Mapper<U>().map(jsonArray[1]) else {
      throw Error.JSONMapping(self)
    }
    return (firstObject, secondObject)
  }

}

extension ObservableType where E == Response {

  func mapPair<T: Mappable, U: Mappable>(type1: T.Type, _ type2: U.Type) -> Observable<(T, U)> {
    return flatMap { response -> Observable<(T, U)> in
      return Observable.just(try response.mapPair())
    }
  }
}
