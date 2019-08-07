//
//  APIClient.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation

class APIClient {
    
    enum APIClientError: Error {
        case failedCreatingURL
        case encodingFailed(Error)
        case dataTaskFailed(Error)
        case nilData
        case decodingFailed(Error)
    }
    
    typealias FetchResult<T> = Result<T, APIClientError>
    typealias FetchCallback<T> = (FetchResult<T>) -> Void
    
    static let APIBaseLocation = "https://api.unsplash.com/"
    
    func fetch<R: APIRequest>(request: R, _ callback: @escaping FetchCallback<R.Response>) {
        guard let urlString = URL(string: APIClient.APIBaseLocation)?.appendingPathComponent(request.location).absoluteString,
            var urlComponents = URLComponents(string: urlString) else {
            callback(.failure(.failedCreatingURL))
            return
        }
        
        if let queryItems = request.queryItems {
            urlComponents.queryItems = queryItems.map({key, value in URLQueryItem(name: key, value: value) })
        }
        
        guard let url = urlComponents.url else {
            callback(.failure(.failedCreatingURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = request.verb.rawValue
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("v1", forHTTPHeaderField: "Accept-Version")
        req.addValue("Client-ID \(Keys.accessKey)", forHTTPHeaderField: "Authorization")
        
        if request.verb == .post {
            do {
                req.httpBody = try JSONEncoder().encode(request)
            } catch let error {
                callback(.failure(.encodingFailed(error)))
                return
            }
        }
        
        URLSession.shared.dataTask(with: req) { (data: Data?, respose: URLResponse?, error: Error?) in
            if let error = error {
                callback(.failure(.dataTaskFailed(error)))
                return
            }
            
            guard let data = data else {
                callback(.failure(.nilData))
                return
            }
            
            print(respose!)
            
            do {
                let resp = try JSONDecoder().decode(R.Response.self, from: data)
                callback(.success(resp))
            } catch let error {
                callback(.failure(.decodingFailed(error)))
            }
        }.resume()
    }
}
