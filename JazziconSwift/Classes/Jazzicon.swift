//
//  Jazzicon.swift
//  JazziconSwift
//
//  Created by Chung Tran on 28/05/2021.
//

import Foundation
import GameplayKit

struct Jazzicon {
    // MARK: - Constants
    private static var wobble = 30
    
    /// Generate random jazzicon
    /// - Parameter size: size of the image (width = height)
    /// - Returns: an instance of UIImage
    static func generate(size: CGFloat) -> UIImage {
        // create generator
        let seed = UInt64.random(in: 0..<10000000)
        let generator = GKMersenneTwisterRandomSource(seed: seed)
        
        let remainingColors = hueShift(colors: UIColor.jazziconColors, generator: generator)
        
        
    }
    
    // MARK: - Helpers
    private static func hueShift(
        colors: [UIColor],
        generator: GKMersenneTwisterRandomSource
    ) -> [UIColor]{
        let amount = (generator.nextInt() * 30) - (wobble / 2)
        return colors.map { $0.rotated(degrees: amount) }
    }
}
