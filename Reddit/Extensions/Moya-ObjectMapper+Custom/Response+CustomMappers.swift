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
