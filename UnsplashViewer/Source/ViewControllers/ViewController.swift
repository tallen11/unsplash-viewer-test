//
//  ViewController.swift
//  UnsplashViewer
//
//  Created by Tate Allen on 8/6/19.
//  Copyright © 2019 Tate Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var refreshControl = UIRefreshControl()
    
    let handler = CollectionViewHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self.handler
        self.collectionView.delegate = self.handler
        self.collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.refreshControl = self.refreshControl
        
        self.refreshControl.addTarget(self, action: #selector(self.collectionViewRefreshed(_:)), for: .valueChanged)
        
        self.handler.fetchPhotos(collectionView: self.collectionView)
    }
    
    @objc private func collectionViewRefreshed(_ sender: Any) {
        self.handler.fetchPhotos(collectionView: self.collectionView) {
            self.refreshControl.endRefreshing()
        }
    }
}
