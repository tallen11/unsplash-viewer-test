//
//  APIRequest.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation

enum HTTPVerb: String {
    case get = "get"
    case post = "post"
}

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var verb: HTTPVerb { get }
    var location: String { get }
    var queryItems: [String: String]? { get }
}
