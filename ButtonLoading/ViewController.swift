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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func buttonTap(sender: AnyObject?) {
        button.animate()
    }
    

}

