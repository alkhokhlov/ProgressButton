//
//  OvalLayer.swift
//  ButtonLoading
//
//  Created by Alexandr on 10.10.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

protocol OvalProtocol: class {
    func ovalAnimationDidStop()
}

class OvalLayer: CAShapeLayer, CAAnimationDelegate {
    
    var parentBounds: CGRect!
    var ovalFrame: CGRect!
    var radius: CGFloat = 5.0
    var progress: CGFloat = 0
    var previousState: CGFloat = 0
    weak var delegateAnimation: OvalProtocol?
    
    override init() {
        super.init()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillProperties(parentBounds: CGRect, color: UIColor) {
        self.parentBounds = parentBounds
        ovalFrame = CGRect(x: parentBounds.size.width/2-radius, y: 0, width: radius*2, height: radius*2)
        radius = parentBounds.size.height/14
        
        frame = parentBounds
        fillColor = color.cgColor
        path = oval.cgPath
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        opacity = 0
    }
    
    var oval: UIBezierPath {
        return UIBezierPath(ovalIn: ovalFrame)
    }
    
    func fadeOut() {
        let animationFadeOut = CABasicAnimation(keyPath: "opacity")
        animationFadeOut.fromValue = 0.0
        animationFadeOut.toValue = 1.0
        animationFadeOut.duration = 0.2
        animationFadeOut.fillMode = kCAFillModeForwards
        animationFadeOut.isRemovedOnCompletion = false
        add(animationFadeOut, forKey: nil)
    }
    
    func fadeIn() {
        let animationFadeIn = CABasicAnimation(keyPath: "opacity")
        animationFadeIn.fromValue = 1.0
        animationFadeIn.toValue = 0.0
        animationFadeIn.duration = 0.2
        animationFadeIn.fillMode = kCAFillModeForwards
        animationFadeIn.isRemovedOnCompletion = false
        add(animationFadeIn, forKey: nil)
    }
    
    func loading() {
        let animationRotate = CABasicAnimation(keyPath: "transform.rotation")
        animationRotate.delegate = self
        animationRotate.fromValue = previousState
        animationRotate.toValue = CGFloat(M_PI)/CGFloat(50.0)*progress
        animationRotate.duration = 0.5
        animationRotate.fillMode = kCAFillModeForwards
        animationRotate.isRemovedOnCompletion = false
        add(animationRotate, forKey: nil)
        previousState = animationRotate.toValue as! CGFloat
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if progress == 100 {
            delegateAnimation?.ovalAnimationDidStop()
            progress = 0
        }
    }
    
}
