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
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
//        let img = photos[indexPath.item]
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
