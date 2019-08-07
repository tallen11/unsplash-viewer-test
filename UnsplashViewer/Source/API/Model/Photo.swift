//
//  Photo.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let description: String?
    let width: Int
    let height: Int
    let urls: [String: URL]
}

/*
 "id": "Dwu85P9SOIk",
 "created_at": "2016-05-03T11:00:28-04:00",
 "updated_at": "2016-07-10T11:00:01-05:00",
 "width": 2448,
 "height": 3264,
 "color": "#6E633A",
 "downloads": 1345,
 "likes": 24,
 "liked_by_user": false,
 "description": "A man drinking a coffee.",
 "exif": {
     "make": "Canon",
     "model": "Canon EOS 40D",
     "exposure_time": "0.011111111111111112",
     "aperture": "4.970854",
     "focal_length": "37",
     "iso": 100
 },
 "location": {
     "city": "Montreal",
     "country": "Canada",
     "position": {
     "latitude": 45.4732984,
     "longitude": -73.6384879
 }
 },
 "tags": [
 { "title": "man" },
 { "title": "drinking" },
 { "title": "coffee" }
 ],
 "current_user_collections": [ // The *current user's* collections that this photo belongs to.
 {
 "id": 206,
 "title": "Makers: Cat and Ben",
 "published_at": "2016-01-12T18:16:09-05:00",
 "updated_at": "2016-07-10T11:00:01-05:00",
 "curated": false,
 "cover_photo": null,
 "user": null
 },
 // ... more collections
 ],
 "urls": {
 "raw": "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d",
 "full": "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg",
 "regular": "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=1080&fit=max",
 "small": "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=400&fit=max",
 "thumb": "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=200&fit=max"
 },
 "links": {
 "self": "https://api.unsplash.com/photos/Dwu85P9SOIk",
 "html": "https://unsplash.com/photos/Dwu85P9SOIk",
 "download": "https://unsplash.com/photos/Dwu85P9SOIk/download"
 "download_location": "https://api.unsplash.com/photos/Dwu85P9SOIk/download"
 },
 "user": {
 "id": "QPxL2MGqfrw",
 "updated_at": "2016-07-10T11:00:01-05:00",
 "username": "exampleuser",
 "name": "Joe Example",
 "portfolio_url": "https://example.com/",
 "bio": "Just an everyday Joe",
 "location": "Montreal",
 "total_likes": 5,
 "total_photos": 10,
 "total_collections": 13,
 "links": {
 "self": "https://api.unsplash.com/users/exampleuser",
 "html": "https://unsplash.com/exampleuser",
 "photos": "https://api.unsplash.com/users/exampleuser/photos",
 "likes": "https://api.unsplash.com/users/exampleuser/likes",
 "portfolio": "https://api.unsplash.com/users/exampleuser/portfolio"
 }
 }
*/
