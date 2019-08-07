//
//  GetPhotosRequest.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation

struct GetPhotosRequest: APIRequest {
    
    enum PhotosOrdering: String, Encodable {
        case latest = "latest"
        case oldest = "oldest"
        case popular = "popular"
    }
    
    typealias Response = [Photo]
    
    let page: Int
    let perPage: Int
    let ordering: PhotosOrdering
    
    init(page: Int = 1, perPage: Int = 10, ordering: PhotosOrdering = .latest) {
        self.page = page
        self.perPage = perPage
        self.ordering = ordering
    }
    
    var verb: HTTPVerb {
        return .get
    }
    
    var location: String {
        return "photos"
    }
    
    var queryItems: [String : String]? {
        return [
            "page": "\(self.page)",
            "per_page": "\(self.perPage)",
            "order_by": self.ordering.rawValue,
        ]
    }
}
