//
//  CollectionViewHandler.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/7/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewHandler: NSObject {
    
    enum ImageCacheStatus {
        case loading
        case done(UIImage)
        case failed
    }
    
    typealias FetchPhotosCallback = () -> Void
    
    let itemsPerRow = 3
    let spacing: CGFloat = 15.0
    
    var photos: [Photo]
    let imageDownloader: ImageDownloader
    var imageCache: [URL: ImageCacheStatus]
    
    override init() {
        self.photos = [Photo]()
        self.imageDownloader = ImageDownloader()
        self.imageCache = [URL: ImageCacheStatus]()
        
        super.init()
    }
    
    func fetchPhotos(collectionView: UICollectionView, _ callback: FetchPhotosCallback? = nil) {
        self.imageDownloader.cancelDownloads()
        self.imageCache.removeAll()
        
        APIClient().fetch(request: GetRandomPhotosRequest()) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self.photos = photos
                    collectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
                
                callback?()
            }
        }
    }
}

extension CollectionViewHandler: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = self.photos[indexPath.row]
        guard let thumbURL = photo.urls["thumb"] else {
            return cell
        }
        
        if let status = self.imageCache[thumbURL] {
            switch status {
            case .loading:
                cell.activityIndicator.startAnimating()
                cell.thumbnailImageView.isHidden = true
            case .done(let image):
                cell.activityIndicator.stopAnimating()
                cell.thumbnailImageView.image = image
                cell.thumbnailImageView.isHidden = false
            case .failed:
                cell.activityIndicator.stopAnimating()
                cell.thumbnailImageView.isHidden = true
            }
        } else {
            self.imageCache[thumbURL] = .loading
            collectionView.reloadItems(at: [indexPath])
            
            self.imageDownloader.downloadImage(from: thumbURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.imageCache[thumbURL] = .done(image)
                        collectionView.reloadItems(at: [indexPath])
                    case .failure(let error):
                        self.imageCache[thumbURL] = .failed
                        print(error)
                    }
                }
            }
        }
        
        return cell
    }
}

extension CollectionViewHandler: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CollectionViewHandler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        let horizMargins: CGFloat = self.spacing * 2.0
        let horizSpacing: CGFloat = CGFloat(self.itemsPerRow - 1) * self.spacing
        
        let itemSize = (size.width - horizMargins - horizSpacing) / CGFloat(self.itemsPerRow)
        
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.spacing, left: self.spacing, bottom: self.spacing, right: self.spacing)
    }
}
