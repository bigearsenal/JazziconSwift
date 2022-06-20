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
    @IBOutlet weak var imageView: JazziconImageView! {
        didSet {
            imageView.layer.cornerRadius = 100
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var seedTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func randomSeedButtonDidTouch(_ sender: Any) {
        seedTextField.text = "\(UInt64.random(in: 0..<1000000))"
        generate()
    }
    
    @IBAction func seedDidEnter(_ sender: Any) {
        generate()
    }
    
    func generate() {
        let seed = UInt32(seedTextField.text ?? "")
        imageView.seed = seed ?? 1
    }
}


