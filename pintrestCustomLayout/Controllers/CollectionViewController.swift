//
//  CollectionViewController.swift
//  pintrestCustomLayout
//
//  Created by Mani on 03/07/17.
//  Copyright © 2017 Mani All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var numberOfItems:Int = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView?.collectionViewLayout as? customCollectionViewLayout
        layout?.delegate = self
        
        layout?.numberOfColumns = 2
        layout?.cellPadding = 4
        collectionView?.contentInset = UIEdgeInsets(top: 20, left: 5, bottom: 5, right: 5)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView?.backgroundColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MyCustomCollectionViewCell
        cell?.myimageView.image = nil
        cell?.myimageView.setImage(forIndex: indexPath.item)
        return cell!
    }
    
}

extension CollectionViewController: customCollectionViewLayoutDelegate {
   
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let randomIndex = arc4random_uniform(19)
        let photo:UIImage = UIImage(named: "\(randomIndex + 1)")!
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let frame = AVMakeRect(aspectRatio: photo.size, insideRect: boundingRect)
        return frame.height
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width:CGFloat) -> CGFloat {
        return 0
    }
    
}
