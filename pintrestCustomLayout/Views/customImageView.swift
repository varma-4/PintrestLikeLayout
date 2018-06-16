//
//  customImageView.swift
//  pintrestCustomLayout
//
//  Created by Mani on 03/07/17.
//  Copyright © 2017 Mani All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class customImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var index:Int?
    
    func setImage(forIndex indexValue:Int) {
        self.image = nil
        index = indexValue
        
        if let image = imageCache.object(forKey: indexValue as AnyObject) as? UIImage {
            self.image = image
            return
        }
        
        if index == indexValue {
            let randomIndex = arc4random_uniform(19)
            let image = UIImage(named: "\(randomIndex + 1)")!
            let imageToCache = image
            imageCache.setObject(imageToCache, forKey: indexValue as AnyObject)
            DispatchQueue.main.async {
                self.image = imageToCache
            }
        }
    }
}
