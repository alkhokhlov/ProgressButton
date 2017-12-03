//
//  LabelLayer.swift
//  ButtonLoading
//
//  Created by Alexandr on 09.10.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

final class LabelLayer: CATextLayer {
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillProperties(text: String, titleFont: UIFont, parentBounds: CGRect, color: UIColor) {
        frame = CGRect(x: 0, y: (parentBounds.size.height-titleFont.pointSize)/2, width: parentBounds.size.width, height: titleFont.pointSize)
        string = text
        fontSize = titleFont.pointSize - 2
        font = CTFontCreateWithName((titleFont.fontName as CFString?)!, fontSize, nil)
        foregroundColor = color.cgColor
        isWrapped = true
        alignmentMode = kCAAlignmentCenter
        contentsScale = UIScreen.main.scale
        opacity = 0.0
    }
    
    func show() {
        opacity = 1.0
    }
    
    
}
