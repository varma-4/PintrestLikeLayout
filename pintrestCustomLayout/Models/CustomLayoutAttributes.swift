//
//  CustomLayoutAttributes.swift
//  pintrestCustomLayout
//
//  Created by Mani on 03/07/17.
//  Copyright © 2017 Mani All rights reserved.
//

import UIKit

class CustomLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight: CFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CustomLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CustomLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                super.isEqual(object)
                return true
            }
        }
        return false
    }

}
