//
//  SwipeView.swift
//  LoveGuru
//
//  Created by Kashish Goel on 2015-07-24.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import Foundation
import UIKit

class SwipeView:UIView {
    
    
    enum Direction {
        case None
        case Left
        case Right
    }
    
    var delegate:SwipeviewDelegate?
    let overlay :UIImageView = UIImageView()
    var direction:Direction?
    
    var innerView :UIView? {
        didSet {
            if let v = innerView {
                insertSubview(v, belowSubview: overlay)
                
                v.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
                
            }
            
        }
        
        
    }
    private var originalPoint:CGPoint?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        initialize()
    }
    
    override  init(frame: CGRect) {
        super.init(frame:frame)
        initialize()
    }
    
    convenience init () {
        self.init()
        initialize()
        
    }
    
    private func initialize() {
        backgroundColor = UIColor.clearColor()
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        originalPoint = center
        
        overlay.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.addSubview(overlay)
        
    }
    
    func dragged (gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translationInView(self)
        println("Distance x: \(distance.x), y: \(distance.y)")
        
        
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            originalPoint = center
        case UIGestureRecognizerState.Changed:
            let rotationPercentage = min(distance.x/self.superview!.frame.width/2, 1)
            let rotationAngle = (CGFloat(2*M_PI/16) * rotationPercentage)
            transform = CGAffineTransformRotate(transform, rotationAngle)
            center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
            updateOverlay(distance.x)
        case UIGestureRecognizerState.Ended:
            resetViewPositionAndTransformations()
            if abs(distance.x) < frame.width/4 {
                resetViewPositionAndTransformations()
            }
            else {
                swipe(distance.x > 0 ? .Right : .Left)
            }
        default:
            println("default")
            break
            
        }
        
    }
    
    private func resetViewPositionAndTransformations () {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0)
            self.overlay.alpha = 0
        })
        
    }
    
    func swipe(s:Direction) {
        if s == .None {
            return
        }
        var parentWidth = superview!.frame.size.width
        if s == .Left {
            parentWidth *= -1
        }
        UIView.animateWithDuration(0.2, animations: {
            self.center.x = self.frame.origin.x + parentWidth
            }, completion: {
                success in
                if let d = self.delegate {
                    s == .Right ? d.swipedRight() : d.swipedLeft()
                    
                }
        })
        
    }
    
    private func updateOverlay(distance:CGFloat) {
        var newDirection: Direction
        newDirection = distance < 0 ? .Left : .Right
        if newDirection != direction {
        direction = newDirection
            overlay.image = direction == .Right ? UIImage(named: "yeah-stamp") : UIImage(named: "nah-stamp")
        }
        overlay.alpha = abs(distance) / (superview!.frame.width/2)
        
        
    }
    
    
}


protocol SwipeviewDelegate: class {
    func swipedLeft()
    func swipedRight()
}