//
//  GetPhotoRequest.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation

struct GetPhotoRequest: APIRequest {
    
    typealias Response = Photo
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var verb: HTTPVerb {
        return .get
    }
    
    var location: String {
        return "photos/\(self.id)"
    }
    
    var queryItems: [String : String]? {
        return nil
    }
}
