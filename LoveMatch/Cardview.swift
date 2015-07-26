//
//  Cardview.swift
//  LoveGuru
//
//  Created by Kashish Goel on 2015-07-24.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import Foundation
import UIKit

class CardView:UIView {
    
    
    private let imageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel ()
    
    var name : String? {
        didSet {
            if let name = name {
            nameLabel.text = name
            }
        
        }
    
    }
    
    
    var image: UIImage? {
        didSet {
        
            if let image = image {
            imageView.image = image
            }
        }
    
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        initialize()
        
    }
    convenience init () {
        self.init(frame:CGRectZero)
        initialize()
    }
    
    private func initialize () {
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.backgroundColor = UIColor.redColor()
        self.addSubview(imageView)
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(nameLabel)
        backgroundColor = UIColor.whiteColor()
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setConstraints()
        
    }
    
    private func setConstraints () {
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -10))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        
        
    }
    
}
