//
//  OpenGraphViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Alamofire
import RxAlamofire

class OpenGraphViewModel: ViewModel {

  private static let facebookBotUserAgent = "Facebot"

  private let openGraph: Variable<OpenGraph?> = Variable(nil)
  private let url: NSURL
  private let disposeBag = DisposeBag()

  var imageURL: Observable<NSURL?> {
    return openGraph.asObservable().map { $0?.imageURL }
  }

  var title: Observable<String?> {
    return openGraph.asObservable().map { $0?.title }
  }

  var linkDescription: Observable<String?> {
    return openGraph.asObservable().map { $0?.description }
  }

  var appLink: Observable<NSURL?> {
    return openGraph.asObservable().map { $0?.appLink?.url }
  }

  init(url: NSURL) {
    self.url = url
  }
}

// MARK: Network
extension OpenGraphViewModel {

  func requestOpenGraph() {
    let headers = ["User-Agent": OpenGraphViewModel.facebookBotUserAgent]
    requestString(Method.GET, url.absoluteString, headers: headers).debug()
      .observeOn(MainScheduler.instance)
      .bindNext { [weak self] (_, html) in
        self?.openGraph.value = OpenGraph(html: html)
      }.addDisposableTo(disposeBag)
  }

}
