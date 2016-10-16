//
//  ViewController.swift
//  ButtonLoading
//
//  Created by Alexandr on 08.10.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button: ProgressButton!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.cornerRadius = 10.0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func buttonTap(sender: AnyObject?) {
        button.animate()
        adjustMochTimer() // Moch
    }
    
    //MARK: - Downloading moch
    
    func adjustMochTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.015,
                                     target: self,
                                     selector: #selector(ViewController.slowIncrementor),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func slowIncrementor() {
        if button.progress == 99 {
            timer?.invalidate()
        }
        button.progress += 1
    }

}

