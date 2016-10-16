//
//  RectangleLayer.swift
//  ButtonLoading
//
//  Created by Alexandr on 09.10.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

protocol RectangleProtocol: class {
    func rectangleAnimationDidStop()
}

class RectangleLayer: CAShapeLayer, CAAnimationDelegate {
    
    var initialCornerRadius: CGFloat = 1.0
    var parentBounds: CGRect!
    var frameRect: CGRect!
    var frameSquare: CGRect!
    weak var delegateAnimation: RectangleProtocol?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillProperties(parentBounds: CGRect, color: UIColor) {
        self.parentBounds = parentBounds
        frameRect = CGRect(x: 0, y: parentBounds.size.height/4, width: parentBounds.size.width, height: parentBounds.size.height/2)
        frameSquare = CGRect(x: frameRect.size.width/2-frameRect.size.height/2, y: frameRect.size.height/2, width: frameRect.size.height, height: frameRect.size.height)
        
        path = rectangle.cgPath
        fillColor = color.cgColor
    }
    
    var rectangle: UIBezierPath {
        return UIBezierPath(roundedRect: frameRect, cornerRadius: initialCornerRadius)
    }
    
    var roundedRectangle: UIBezierPath {
        return UIBezierPath(roundedRect: frameRect, cornerRadius: frameRect.size.height/2)
    }
    
    var roundedSquare: UIBezierPath {
        return UIBezierPath(roundedRect: frameSquare, cornerRadius: frameSquare.size.height/2)
    }
    
    func animate() {
        let animationRoundedRectangle = CABasicAnimation(keyPath: "path")
        animationRoundedRectangle.fromValue = rectangle.cgPath
        animationRoundedRectangle.toValue = roundedRectangle.cgPath
        animationRoundedRectangle.beginTime = 0.0
        animationRoundedRectangle.duration = 0.4
        
        let animationSquare = CABasicAnimation(keyPath: "path")
        animationSquare.fromValue = roundedRectangle.cgPath
        animationSquare.toValue = roundedSquare.cgPath
        animationSquare.beginTime = animationRoundedRectangle.beginTime + animationRoundedRectangle.duration
        animationSquare.duration = 0.4
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationRoundedRectangle, animationSquare]
        animationGroup.delegate = self
        animationGroup.duration = animationSquare.beginTime + animationSquare.duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        add(animationGroup, forKey: nil)
    }
    
    func animateInitialState() {
        let animationRectangle = CABasicAnimation(keyPath: "path")
        animationRectangle.fromValue = roundedSquare.cgPath
        animationRectangle.toValue = rectangle.cgPath
        animationRectangle.duration = 0.4
        animationRectangle.fillMode = kCAFillModeForwards
        animationRectangle.isRemovedOnCompletion = false
        add(animationRectangle, forKey: nil)
    }
    
    func animateSuccessColor() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.white.cgColor
        animation.toValue = UIColor.green.cgColor
        animation.duration = 0.4
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegateAnimation?.rectangleAnimationDidStop()
    }
    
    
}
