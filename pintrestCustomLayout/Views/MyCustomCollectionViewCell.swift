//
//  MyCustomCollectionViewCell.swift
//  pintrestCustomLayout
//
//  Created by Mani on 03/07/17.
//  Copyright © 2017 Mani All rights reserved.
//

import UIKit

class MyCustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myimageView: customImageView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as? CustomLayoutAttributes
        heightConstraint.constant = CGFloat(attributes!.photoHeight)
    }
    
}
