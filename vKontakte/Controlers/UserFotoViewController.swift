//
//  UserFotoViewController.swift
//  vKontakte
//
//  Created by Andrew on 27/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class UserFotoViewController: UICollectionViewController {

    public var userId: Int? = 1
    public var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = userId {
            NetworkService.fetchPhotos(for: userId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let photos):
                    self.photos = photos
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        cell.configurePhotos(with: photos[indexPath.item])
        let opacity = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacity.fromValue = 0
        opacity.toValue = 1
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 0.1
        scale.toValue = 1
        let animGroup = CAAnimationGroup ()
        animGroup.duration = 1
        animGroup.animations = [opacity, scale]
        
        cell.layer.add(animGroup, forKey: nil)
        return cell
    }

}
