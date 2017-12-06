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

  case AccessToken(code: String, redirectURL: String, clientId: String)
  case RefreshToken(refreshToken: String, clientId: String)
  case SubredditListing(token: String, after: String?)
  case DefaultSubredditListing(after: String?)
  case MultiredditListing(token: String)
  case LinkDetails(token: String, permalink: String)
  case LinkListing(token: String, path: String, listingPath: String, listingTypeRange: String?,
    after: String?)
  case UserDetails(token: String, username: String)
  case UserMeDetails(token: String)
  case Vote(token: String, identifier: String, direction: Int)
  case Save(token: String, identifier: String)
  case Unsave(token: String, identifier: String)
  case Report(token: String, identifier: String, reason: String)

}

extension RedditAPI: TargetType {

  var baseURL: NSURL {
    guard let _ = token else {
      return NSURL(string: "https://www.reddit.com")!
    }
    return NSURL(string: "https://oauth.reddit.com")!
  }

  var path: String {
    switch self {
    case .AccessToken, RefreshToken:
      return "/api/v1/access_token"
    case .MultiredditListing:
      return "/api/multi/mine"
    case .SubredditListing:
      return "/subreddits/mine"
    case .DefaultSubredditListing:
      return "/subreddits/default"
    case .LinkListing(_, let path, let listingPath, _, _):
      return "\(path)\(listingPath)"
    case .LinkDetails(_, let permalink):
      return permalink
    case .UserMeDetails(_):
      return "/api/v1/me"
    case .UserDetails(_, let username):
      return "/user/\(username)/about"
    case .Vote:
      return "/api/vote"
    case .Save:
      return "/api/save"
    case .Unsave:
      return "/api/unsave"
    case .Report:
      return "/api/report"
    }
  }

  var method: Moya.Method {
    switch self {
    case .AccessToken, .RefreshToken, .Vote, .Save, .Unsave, .Report:
      return .POST
    default:
      return .GET
    }
  }

  var parameters: [String: AnyObject]? {
    switch self {
    case .AccessToken(let code, let redirectURL, _):
      return [
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirectURL]
    case .RefreshToken(let refreshToken, _):
      return [
        "grant_type": "refresh_token",
        "refresh_token": refreshToken
      ]
    case .SubredditListing(_, let after):
      guard let after = after else {
        return nil
      }
      return ["after": after]
    case .DefaultSubredditListing(let after):
      guard let after = after else {
        return nil
      }
      return ["after": after]
    case .LinkListing(_, _, _, let listingTypeRange, let after):
      guard let after = after else {
        return nil
      }
      return JSONHelper.flatJSON(["after": after, "t": listingTypeRange])
    case .Vote(_, let identifier, let direction):
      return ["id": identifier, "dir": direction]
    case .Save(_, let identifier):
      return ["id": identifier]
    case .Unsave(_, let identifier):
      return ["id": identifier]
    case .Report(_, let identifier, let reason):
      return ["thing_id": identifier, "reason": reason]
    default:
      return nil
    }
  }

  var sampleData: NSData {
    switch self {
    case .AccessToken, .RefreshToken:
      return JSONReader.readJSONData("AccessToken")
    case .SubredditListing:
      return JSONReader.readJSONData("SubredditListing")
    case .DefaultSubredditListing:
      return JSONReader.readJSONData("SubredditListing")
    case .LinkListing:
      return JSONReader.readJSONData("LinkListing")
    case .MultiredditListing:
      return JSONReader.readJSONData("MultiredditListing")
    case .LinkDetails:
      return JSONReader.readJSONData("LinkDetails")
    case .UserDetails, .UserMeDetails:
      return JSONReader.readJSONData("UserDetails")
    case .Vote:
      return JSONReader.readJSONData("Upvoted")
    default:
      return NSData()
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
    case .AccessToken, .RefreshToken:
      return .URL
    case .Vote, . Save, .Unsave, .Report:
      return .URLEncodedInURL
    default:
      return method == .GET ? .URL : .JSON
    }
  }

  var token: String? {
    switch self {
    case .SubredditListing(let token, _):
      return token
    case .LinkListing(let token, _, _, _, _):
      return token
    case .MultiredditListing(let token):
      return token
    case .LinkDetails(let token, _):
      return token
    case .UserDetails(let token, _):
      return token
    case .UserMeDetails(let token):
      return token
    case .Vote(let token, _, _):
      return token
    case .Save(let token, _):
      return token
    case .Unsave(let token, _):
      return token
    case .Report(let token, _, _):
      return token
    default:
      return nil
    }
  }

  var url: String {
    return "\(baseURL)\(path).json"
  }

  var multipartBody: [MultipartFormData]? {
    return nil
  }

  var credentials: NSURLCredential? {
    switch self {
    case .AccessToken(_, _, let clientId):
      return NSURLCredential(user: clientId, password: "", persistence: .None)
    case .RefreshToken(_, let clientId):
      return NSURLCredential(user: clientId, password: "", persistence: .None)
    default:
      return nil
    }
  }

}
