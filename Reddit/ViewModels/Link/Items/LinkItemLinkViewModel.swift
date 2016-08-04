//
//  LinkItemLinkViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

// MARK: Properties and initializer
class LinkItemLinkViewModel: LinkItemViewModel {

  // MARK: Constants
  private static let facebookBotUserAgent = "Facebot"

  // MARK: Private Properties
  private let openGraph: Variable<OpenGraph?> = Variable(nil)

  // MARK: Observables
  var openGraphImageURL: Observable<NSURL?> {
    return openGraph.asObservable().map { $0?.imageURL }
  }

  var openGraphTitle: Observable<String?> {
    return openGraph.asObservable().map { $0?.title }
  }

  var openGraphDescription: Observable<String?> {
    return openGraph.asObservable().map { $0?.description }
  }

  var appLink: Observable<NSURL?> {
    return openGraph.asObservable().map { $0?.appLink?.url }
  }

  // MARK: API
  override func preloadData() {
    requestOpenGraph()
  }
}


extension LinkItemLinkViewModel {

  func requestOpenGraph() {
    let headers = ["User-Agent": LinkItemLinkViewModel.facebookBotUserAgent]
    requestString(Method.GET, link.url.absoluteString, headers: headers)
      .observeOn(MainScheduler.instance)
      .bindNext { [weak self] (_, html) in
        self?.openGraph.value = OpenGraph(html: html)
      }.addDisposableTo(disposeBag)
  }
}
