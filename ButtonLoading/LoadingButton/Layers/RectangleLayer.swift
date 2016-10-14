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
    
    var parentBounds: CGRect!
    var frameRect: CGRect!
    var frameSquare: CGRect!
    weak var delegateAnimation: RectangleProtocol?
    
    override init() {
        super.init()
    }
    
    func fillProperties(parentBounds: CGRect, color: UIColor) {
        self.parentBounds = parentBounds
        frameRect = CGRect(x: 0, y: parentBounds.size.height/4, width: parentBounds.size.width, height: parentBounds.size.height/2)
        frameSquare = CGRect(x: frameRect.size.width/2-frameRect.size.height/2, y: frameRect.size.height/2, width: frameRect.size.height, height: frameRect.size.height)
        
        path = rectangle.cgPath
        fillColor = color.cgColor
    }
    
    override func draw(in ctx: CGContext) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var rectangle: UIBezierPath {
        return UIBezierPath(roundedRect: frameRect, cornerRadius: frameRect.size.height/2)
    }
    
    var roundedSquare: UIBezierPath {
        return UIBezierPath(roundedRect: frameSquare, cornerRadius: frameSquare.size.height/2)
    }
    
    func animate() {
        let animationSquare = CABasicAnimation(keyPath: "path")
        animationSquare.delegate = self
        animationSquare.fromValue = rectangle.cgPath
        animationSquare.toValue = roundedSquare.cgPath
        animationSquare.duration = 0.4
        animationSquare.fillMode = kCAFillModeForwards
        animationSquare.isRemovedOnCompletion = false
        add(animationSquare, forKey: nil)
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
