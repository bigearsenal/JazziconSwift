//
//  ViewController.swift
//  JazziconSwift
//
//  Created by Chung Tran on 05/28/2021.
//  Copyright (c) 2021 Chung Tran. All rights reserved.
//

import UIKit
import JazziconSwift

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateButtonDidTouch(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateButtonDidTouch(_ sender: Any) {
        let image = Jazzicon.generate(size: 200)
        imageView.image = image
    }
}

