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
  case MultiredditListing(token: String)
  case LinkDetails(token: String?, permalink: String)
  case LinkListing(token: String?, subredditName: String, listing: ListingType, after: String?)
  case UserDetails(token: String?, username: String)

}

extension RedditAPI: TargetType {

  var baseURL: NSURL { return NSURL(string: Constants.baseURL)! }

  var path: String {
    switch self {
    case .SubredditListing:
      return "/api/multi/mine"
    case .MultiredditListing:
      return "/subreddits/mine"
    case .LinkListing(_, let subredditName, let listing, _):
      return "/r/\(subredditName)/\(listing.path)"
    case .LinkDetails(_, let permalink):
      return permalink
    case .UserDetails(_, let username):
      return "/user/\(username)/about"
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
    default:
      return nil
    }
  }

  var sampleData: NSData {
    switch self {
    case .SubredditListing:
      return JSONReader.readJSONData("SubredditListing")
    case .LinkListing:
      return JSONReader.readJSONData("LinkListing")
    case .MultiredditListing:
      return JSONReader.readJSONData("MultiredditListing")
    case .LinkDetails:
      return JSONReader.readJSONData("LinkDetails")
    case .UserDetails:
      return JSONReader.readJSONData("UserDetails")
    }
  }

  var headers: [String: String]? {
    guard let token = token else {
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

  var token: String? {
    switch self {
    case .SubredditListing(let token, _):
      return token
    case .LinkListing(let token, _, _, _):
      return token
    case .MultiredditListing(let token):
      return token
    case .LinkDetails(let token, _):
      return token
    case .UserDetails(let token, _):
      return token
    }
  }

  var url: String {
    return "\(baseURL)\(path).json"
  }

}
