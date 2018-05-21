//
//  customCollectionViewCell.swift
//  pintrestCustomLayout
//
//  Created by Mani on 03/07/17.
//  Copyright © 2017 Mani All rights reserved.
//

import UIKit

protocol customCollectionViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width:CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width:CGFloat) -> CGFloat
}

class customCollectionViewLayout:UICollectionViewLayout {
    
    var delegate:customCollectionViewLayoutDelegate!
    var numberOfColumns = 1
    private var cache = Dictionary<String, CustomLayoutAttributes>()
    
    private var contentHeight:CGFloat = 0
    var cellPadding:CGFloat = 0
    
    private var width:CGFloat {
        get {
            let inset = collectionView!.contentInset
            return ((collectionView?.bounds.width)! - inset.left - inset.right)
        }
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CustomLayoutAttributes.self
    }

    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: width, height: CGFloat(contentHeight))
        }
    }
    
    override func prepare() {
        super.prepare()
        if cache.isEmpty {
            let columnWidth = (width) / CGFloat(numberOfColumns)
            var xOffsets = [CGFloat]()
            var yOffsets = [CGFloat](repeating: 0.0, count: numberOfColumns)
            
            for val in 0..<numberOfColumns {
                xOffsets.append(CGFloat(val) * (columnWidth))
            }
            
            var column = 0
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                
                let index = IndexPath(item: item, section: 0)
                let attributes = CustomLayoutAttributes(forCellWith: index)
                
                let width = columnWidth - (2 * cellPadding)
                let photoHeight = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: index, withWidth: width)
                let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: index, withWidth: width)
                
                let height = cellPadding + photoHeight + annotationHeight + cellPadding
                var offsetValue:Int = 0
                if item >= 2 {
                    offsetValue = yOffsets[0] > yOffsets[1] ? 1 : 0
                } else{
                    offsetValue = column
                }
                let frame = CGRect(x: xOffsets[offsetValue], y: yOffsets[offsetValue], width: columnWidth, height: height)
                
                attributes.photoHeight = CFloat(photoHeight)
                yOffsets[offsetValue] = yOffsets[offsetValue] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
                
                attributes.frame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                cache["\(item)"] = attributes
                contentHeight = max(contentHeight, frame.maxY)
            }
        } else{
            print("Cache is not empty")
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attributes = cache["\(indexPath.item)"] {
            return attributes
        }
        return nil
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for item in 0...cache.count {
            if let attributes = cache["\(item)"] {
                if attributes.frame.intersects(rect){
                    layoutAttributes.append(attributes)
                    
                }
            }
        }
        
        return layoutAttributes
    }

}
