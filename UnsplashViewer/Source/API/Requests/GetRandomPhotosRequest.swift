//
//  GetRandomPhotosRequest.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation

struct GetRandomPhotosRequest: APIRequest {
    
    typealias Response = [Photo]
    
    var verb: HTTPVerb {
        return .get
    }
    
    var location: String {
        return "photos/random"
    }
    
    var queryItems: [String : String]? {
        return [
            "count": "30",
        ]
    }
}
