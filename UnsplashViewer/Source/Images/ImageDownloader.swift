//
//  ImageDownloader.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    
    typealias ImageDownloadedResult = Result<UIImage, DownloadImageOperation.DownloadImageOperationError>
    typealias ImageDownloadedCallback = (ImageDownloadedResult) -> Void
    
    private let downloadQueue: OperationQueue
    
    init() {
        self.downloadQueue = OperationQueue()
        self.downloadQueue.qualityOfService = .userInitiated
    }
    
    func downloadImage(from url: URL, _ callback: @escaping ImageDownloadedCallback) {
        let op = DownloadImageOperation(imageURL: url) { result in
            callback(result)
        }
        
        self.downloadQueue.addOperation(op)
    }
    
    func cancelDownloads() {
        self.downloadQueue.cancelAllOperations()
    }
}
