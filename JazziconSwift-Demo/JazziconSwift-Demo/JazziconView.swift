//
//  JazziconView.swift
//  JazziconSwift-Demo
//
//  Created by Chung Tran on 20/06/2022.
//

import Foundation
import UIKit
import JazziconSwift

class JazziconView: UIView {

    var seed: UInt32 = 1 {
        willSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Override Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let jazzicon = Jazzicon(seed: seed)
        jazzicon.generateImage(context: context, rect: rect)
    }
}
