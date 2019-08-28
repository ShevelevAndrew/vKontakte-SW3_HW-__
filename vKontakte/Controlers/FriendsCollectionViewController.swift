//
//  FriendsCollectionViewController.swift
//  vKontakte
//
//  Created by Andrew on 19/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UICollectionViewController {
    var friendNameForTitle: String = ""
    var friendNameForLabel: String = ""
    var friendNameForImage: UIImage = UIImage(named: "user")!
    var likeCount: String = ""
    var imageCount: Int = 0
    weak var likeCountLabel: UILabel!
    weak var likeButton: Likebutton!
    
    var friends = [FriendModels]()
    
    var photos = [Photo]()
    public var userId: Int?
    
    weak var fotoCollections: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = friendNameForTitle
      
        userId = friends[0].id

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
    
    override func viewDidAppear(_ animated: Bool) {
        likeButton.addTarget(self, action: #selector(likeButtonDidtapped), for: .valueChanged)
    }
    
    // MARK: - Navigation


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForcastCell.reuseIdentifier, for: indexPath) as?
        ForcastCell else { return UICollectionViewCell() }

        let friend = friends[0]
        cell.configure(with: friend)
        
//        cell.likeCount.text = friends[0].likeCount
        likeButton = cell.likeButton
        likeCountLabel = cell.likeCount
        fotoCollections = cell.fotoColection
        
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(getSwipeAction(_:)))
        swipeGestureRight.direction = [.right]
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(getSwipeAction(_:)))
        swipeGestureLeft.direction = [.left]
        
        cell.fotoColection.addGestureRecognizer(swipeGestureRight)
        cell.fotoColection.addGestureRecognizer(swipeGestureLeft)

        let urlImage = URL(string: friends[0].image)
        cell.fotoColection.kf.setImage(with: urlImage)
        
//        if photos.count < 0 {
//        cell.fotoColection.kf.setImage(with: photos[0].photoURL) //image = UIImage(named: imageCollection[0])
//        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImages" {
                if let userImages = segue.destination as? UserFotoViewController {
                    userImages.userId = userId!
            }
        }
    }
    
    @objc func getSwipeAction( _ recognizer : UISwipeGestureRecognizer){
        
        switch recognizer.direction {
        case .right:
            if imageCount != 0 {
                imageCount -= 1
            }
            fotoCollections.kf.setImage(with: photos[imageCount].photoURL) // = UIImage(named: imageCollection[imageCount])
        case .left:
            if imageCount < photos.count - 1 {
                imageCount += 1
            }
            fotoCollections.kf.setImage(with: photos[imageCount].photoURL) // = UIImage(named: imageCollection[imageCount])
       
        default:
            print(recognizer.direction)
        }
    }
    

    // MARK: UICollectionViewDelegate
    
    @objc func likeButtonDidtapped() {
        if likeButton.isLaiked {
            likeCountLabel.text = String(Int(likeCount)! + 1)
        } else {
            likeCountLabel.text = String(Int(likeCountLabel.text!)! - 1)
        }
    }
}


class Likebutton: UIControl {
    var isLaiked: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let sideOne = rect.height * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne * sideOne + sideTwo * sideTwo) / 2
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: rect.height * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
        path.addArc(withCenter: CGPoint(x: rect.height * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.height * 0.5, y: rect.height * 0.95))
        
        path.close()
        
        UIColor.red.setStroke()
        UIColor.red.setFill()
        
        isLaiked ? path.fill() : path.stroke()
    }
    
    func setupView() {
        self.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        //self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = min(self.bounds.height, self.bounds.width) / 5
        clipsToBounds = true
    }
    
    @objc func changeState() {
        isLaiked.toggle()
        self.sendActions(for: .valueChanged)
        setNeedsDisplay() // после изменения перересовать
    }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180}
}



