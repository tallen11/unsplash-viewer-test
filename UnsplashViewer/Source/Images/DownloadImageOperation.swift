//
//  DownloadImageOperation.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation
import UIKit

class DownloadImageOperation: Operation {
    
    enum DownloadImageOperationError: Error {
        case dataTaskFailed(Error)
        case nilData
        case failedCreatingImageFromData
    }
    
    typealias DownloadImageResult = Result<UIImage, DownloadImageOperationError>
    typealias DownloadImageCallback = (DownloadImageResult) -> Void
    
    let imageURL: URL
    let callback: DownloadImageCallback
    
    init(imageURL: URL, _ callback: @escaping DownloadImageCallback) {
        self.imageURL = imageURL
        self.callback = callback
    }
    
    override func main() {
        if self.isCancelled {
            self.setFinished(true)
            return
        }
        
        self.setExecuting(true)
        self.downloadImage()
    }
    
    private func downloadImage() {
        URLSession.shared.dataTask(with: self.imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if self.isCancelled {
                self.setFinished(true)
                self.setExecuting(false)
                return
            }
            
            if let error = error {
                self.callback(.failure(.dataTaskFailed(error)))
                self.setFinished(true)
                self.setExecuting(false)
            }
            
            guard let data = data else {
                self.callback(.failure(.nilData))
                self.setFinished(true)
                self.setExecuting(false)
                return
            }
            
            guard let image = UIImage(data: data) else {
                self.callback(.failure(.failedCreatingImageFromData))
                self.setFinished(true)
                self.setExecuting(false)
                return
            }
            
            if self.isCancelled {
                self.setFinished(true)
                self.setExecuting(false)
                return
            }
            
            self.callback(.success(image))
            
            self.setFinished(true)
            self.setExecuting(false)
        }.resume()
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _cancelled = false {
        willSet {
            willChangeValue(forKey: "isCancelled")
        }
        
        didSet {
            didChangeValue(forKey: "isCancelled")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    override var isCancelled: Bool {
        return _cancelled
    }
    
    func setExecuting(_ exec: Bool) {
        self._executing = exec
    }
    
    func setFinished(_ finished: Bool) {
        self._finished = finished
    }
}
