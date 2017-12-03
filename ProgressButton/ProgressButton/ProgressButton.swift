//
//  LoadingButton.swift
//  ButtonLoading
//
//  Created by Alexandr on 08.10.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit


final class ProgressButton: UIButton, RectangleProtocol, OvalProtocol {
    
    private let checkMarkPlusFontSize:CGFloat = 8.0
    private let timerIntervalAnimation = 0.2
    private var timer: Timer?
    private var color: UIColor!
    private var fontTitle: UIFont!
    private var fontColor: UIColor!
    private var rectangleLayer = RectangleLayer()
    private var ovalLayer = OvalLayer()
    private var labelLayer = LabelLayer()
    var successColor = UIColor(red:0.20, green:0.80, blue:0.40, alpha:1.0)
    var cornerRadius: CGFloat! {
        get {
            return rectangleLayer.initialCornerRadius
        }
        set {
            rectangleLayer.initialCornerRadius = newValue
        }
    }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        color = backgroundColor
        backgroundColor = UIColor.clear
        
        rectangleLayer.delegateAnimation = self
        layer.addSublayer(rectangleLayer)
        
        ovalLayer.delegateAnimation = self
        layer.addSublayer(ovalLayer)
        
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
        titleLabel?.font = UIFont(name: fontTitle.fontName, size: fontTitle.pointSize + checkMarkPlusFontSize)
        setTitleColor(successColor, for: .normal)
    }
    
    //MARK: - RectangleProtocol methods
    
    func rectangleAnimationDidStop() {
        ovalLayer.fadeOut()
        labelLayer.show()
    }
    
    //MARK: - OvalProtocol methods
    
    func ovalAnimationDidStop() {
        timer = Timer.scheduledTimer(withTimeInterval: timerIntervalAnimation, repeats: false, block: { (timer) in
            self.ovalLayer.fadeIn()
            self.successTitle()
            self.rectangleLayer.animateInitialState()
        })
    }
    

}

