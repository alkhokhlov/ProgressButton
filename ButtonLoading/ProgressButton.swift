//
//  LoadingButton.swift
//  ButtonLoading
//
//  Created by Alexandr on 08.10.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

class ProgressButton: UIButton, RectangleProtocol, OvalProtocol {
    
    var timer: Timer?
    var color: UIColor!
    var rectangleLayer: RectangleLayer!
    var ovalLayer: OvalLayer!
    var labelLayer: LabelLayer!
    var progress: CGFloat {
        get {
            return ovalLayer.progress
        }
        set {
            ovalLayer.progress = newValue
            labelLayer.string = String(format: "%.0f", newValue)
            ovalLayer.loading()
        }
    }
    var fontTitle: UIFont!
    var fontColor: UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        color = backgroundColor
        backgroundColor = UIColor.clear
        
        rectangleLayer = RectangleLayer()
        rectangleLayer.delegateAnimation = self
        layer.addSublayer(rectangleLayer)
        
        ovalLayer = OvalLayer()
        ovalLayer.delegateAnimation = self
        layer.addSublayer(ovalLayer)
        
        labelLayer = LabelLayer()
        layer.addSublayer(labelLayer)
        
        fontTitle = titleLabel?.font
        fontColor = titleLabel?.textColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rectangleLayer.fillProperties(parentBounds: bounds, color: color)
        ovalLayer.fillProperties(parentBounds: bounds, color: color)
        labelLayer.fillProperties(text: String(format: "%.0f", progress), titleFont: fontTitle, parentBounds: bounds, color: fontColor)
    }
    
    func animate() {
        hideLabel()
        rectangleLayer.animate()
    }
    
    private func hideLabel() {
        setTitleColor(UIColor.clear, for: .normal)
    }
    
    private func tintColor() {
        setTitleColor(tintColor, for: .normal)
    }
    
    private func successTitle() {
        setTitle("✔︎", for: .normal)
        titleLabel?.font = UIFont(name: fontTitle.fontName, size: fontTitle.pointSize + 8)
        setTitleColor(UIColor(red:0.20, green:0.80, blue:0.40, alpha:1.0), for: .normal)
    }
    
    //MARK: - RectangleProtocol methods
    
    func rectangleAnimationDidStop() {
        adjustMochTimer() //Downloading moch
        ovalLayer.fadeOut()
        labelLayer.show()
    }
    
    //MARK: - OvalProtocol methods
    
    func ovalAnimationDidStop() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (timer) in
            self.ovalLayer.fadeIn()
            self.successTitle()
            self.rectangleLayer.animateInitialState()
        })
    }
    
    //MARK: - Downloading moch
    
    func adjustMochTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.015,
                                     target: self,
                                     selector: #selector(ProgressButton.slowIncrementor),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func slowIncrementor() {
        if progress == 99 {
            timer?.invalidate()
        }
        progress += 1
    }

}

