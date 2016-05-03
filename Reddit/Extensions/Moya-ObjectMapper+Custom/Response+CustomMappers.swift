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

  func mapPair<T: Mappable, U: Mappable>() throws -> (T, U) {
    guard let jsonArray = try mapJSON() as? [AnyObject] where jsonArray.count == 2 else {
      throw Error.JSONMapping(self)
    }
    guard let firstObject = Mapper<T>().map(jsonArray[0]),
      secondObject = Mapper<U>().map(jsonArray[1]) else {
      throw Error.JSONMapping(self)
    }
    return (firstObject, secondObject)
  }

  func mapObject<T: Mappable>(jsonTransform: (AnyObject?) -> AnyObject?) throws -> T {
    let json = try jsonTransform(mapJSON())
    guard let object = Mapper<T>().map(json) else {
      throw Error.JSONMapping(self)
    }
    return object
  }

}

extension ObservableType where E == Response {

  func mapPair<T: Mappable, U: Mappable>(type1: T.Type, _ type2: U.Type) -> Observable<(T, U)> {
    return flatMap { response -> Observable<(T, U)> in
      return Observable.just(try response.mapPair())
    }
  }

  public func mapObject<T: Mappable>(type: T.Type, jsonTransform: (AnyObject?) -> AnyObject?)
    -> Observable<T> {
    return flatMap { response -> Observable<T> in
      return Observable.just(try response.mapObject(jsonTransform))
    }
  }
}
