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

  /**
   Adds a transformation over the initial JSON. Specially useful to reformat wrongfully formatted
   JSON.

   - parameter type: The Type for the ObjectMapper.
   - parameter jsonTransform: Transformation block for the JSON object.

   - throws: Can throw a JSONMapping Error

   - returns: The transformed JSON object.
   */
  func mapObject<T: Mappable>(type: T.Type, jsonTransform: (AnyObject?) -> AnyObject?) throws -> T {
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

  /**
   Adds a transformation over the initial JSON. Specially useful to reformat wrongfully formatted
   JSON.

   - parameter type: The Type for the ObjectMapper.
   - parameter jsonTransform: Transformation block for the JSON object.

   - returns: The transformed JSON Object observable.
   */
  func mapObject<T: Mappable>(type: T.Type, jsonTransform: (AnyObject?) -> AnyObject?)
    -> Observable<T> {
    return flatMap { response -> Observable<T> in
      return Observable.just(try response.mapObject(type, jsonTransform: jsonTransform))
    }
  }
}
