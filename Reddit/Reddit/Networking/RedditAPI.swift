//
//  RedditAPI.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import Moya

enum RedditAPI {

  case AccessToken(authorizationCode: String, redirectURL: String)
  case Listing(token: String?, name: String, listing: ListingType, after: String?)

}

extension RedditAPI: TargetType {

  var baseURL: NSURL { return NSURL(string: Constants.baseURL)! }

  var path: String {
    switch self {
    case .AccessToken:
      return "api/v1/access_token"
    case .Listing(_, let name, let listing, _):
      return "r/\(name)/\(listing.path)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .AccessToken:
      return .POST
    case .Listing:
      return .GET
    }
  }

  var parameters: [String: AnyObject]? {
    switch self {
    case .AccessToken(let authorizationCode, let redirectURL):
      return [
        "grant_type": "authorization_code",
        "code": authorizationCode,
        "redirect_uri": redirectURL]
    case .Listing(_, _, _, let after):
      guard let after = after else {
        return nil
      }
      return ["after": after]
    }
  }

  var sampleData: NSData {
    switch self {
    case .AccessToken:
      return JSONReader.readJSONData("AccessToken")
    case .Listing:
      return JSONReader.readJSONData("Listing")
    }
  }

  var headers: [String: String]? {
    switch self {
    case .Listing(let token, _, _, _):
      guard let token = token else {
        return nil
      }
      return ["Authorization": "bearer \(token)"]
    default:
      return nil
    }
  }

  var parameterEncoding: ParameterEncoding {
    switch self {
    case .AccessToken:
      return ParameterEncoding.Custom {
        (URLRequestConvertible, parameters) -> (NSMutableURLRequest, NSError?) in
        if let string = parameters?.map({ "\($0.0)=\($0.1.description)" }).joinWithSeparator("&") {
          URLRequestConvertible.URLRequest.HTTPBody = string.dataUsingEncoding(NSUTF8StringEncoding)
        }
        return (URLRequestConvertible.URLRequest, nil)
      }
    default:
      return method == .GET ? .URL : .JSON
    }
  }

  var url: String {
    return "\(baseURL)\(path)"
  }

}
