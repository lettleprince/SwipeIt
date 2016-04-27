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

  case SubredditListing(token: String, after: String?)
  case LinkListing(token: String?, subredditName: String, listing: ListingType, after: String?)

}

extension RedditAPI: TargetType {

  var baseURL: NSURL { return NSURL(string: Constants.baseURL)! }

  var path: String {
    switch self {
    case .SubredditListing:
      return "subreddits/mine"
    case .LinkListing(_, let subredditName, let listing, _):
      return "r/\(subredditName)/\(listing.path)"
    }
  }

  var method: Moya.Method {
    switch self {
    default:
      return .GET
    }
  }

  var parameters: [String: AnyObject]? {
    switch self {
    case .SubredditListing(_, let after):
      guard let after = after else {
        return nil
      }
      return ["after": after]
    case .LinkListing(_, _, _, let after):
      guard let after = after else {
        return nil
      }
      return ["after": after]
    }
  }

  var sampleData: NSData {
    switch self {
    case .SubredditListing:
      return JSONReader.readJSONData("SubredditList")
    case .LinkListing:
      return JSONReader.readJSONData("LinkListing")
    }
  }

  var headers: [String: String]? {
    var bearerToken: String? = nil
    switch self {
    case .SubredditListing(let token, _):
      bearerToken = token
    case .LinkListing(let token, _, _, _):
      bearerToken = token
    default:
      return nil
    }
    guard let token = bearerToken else {
      return nil
    }
    return ["Authorization": "bearer \(token)"]
  }

  var parameterEncoding: ParameterEncoding {
    switch self {
    default:
      return method == .GET ? .URL : .JSON
    }
  }

  var url: String {
    return "\(baseURL)\(path).json"
  }

}
