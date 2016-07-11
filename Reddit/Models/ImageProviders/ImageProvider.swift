//
//  ImageProvider.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

protocol ImageProvider {

  static func imageURLFromLink(link: Link) -> NSURL?
}
