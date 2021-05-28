//
//  Jazzicon.swift
//  JazziconSwift
//
//  Created by Chung Tran on 28/05/2021.
//

import Foundation
import GameplayKit

public struct Jazzicon {
    // MARK: - Constants
    private static var wobble = 30
    
    /// Generate random jazzicon
    /// - Parameter size: size of the image (width = height)
    /// - Returns: an instance of UIImage
    public static func generate(size: CGFloat, shapeCount: Int = 8) -> UIImage {
        // create generator
        let seed = UInt64.random(in: 0..<10000000)
        let generator = GKMersenneTwisterRandomSource(seed: seed)
        
        let remainingColors = hueShift(colors: UIColor.jazziconColors, generator: generator)
        
        // drawing
        UIGraphicsBeginImageContextWithOptions(.init(width: size, height: size), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        
        // first shape (without translation, rotation)
        generateFirstShape(
            currentContext: ctx,
            size: size,
            remainingColors: remainingColors,
            generator: generator
        )
        
        // other shapes
        for i in 0..<shapeCount-1 {
            generateOtherShape(
                currentContext: ctx,
                size: size,
                total: shapeCount-1,
                i: i,
                remainingColors: remainingColors,
                generator: generator
            )
        }
        
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return img
    }
    
    // MARK: - Helpers
    private static func generateFirstShape(
        currentContext ctx: CGContext,
        size: CGFloat,
        remainingColors: [UIColor],
        generator: GKMersenneTwisterRandomSource
    ) {
        // preparation
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        ctx.setFillColor(generateColor(from: remainingColors, generator: generator))
        ctx.fill(rect)
        
        // finish
        ctx.restoreGState()
    }
    
    private static func generateOtherShape(
        currentContext ctx: CGContext,
        size: CGFloat,
        total: Int,
        i: Int,
        remainingColors: [UIColor],
        generator: GKMersenneTwisterRandomSource
    ) {
        // preparation
        ctx.saveGState()
        
//        let center = size / 2
        let firstRot = generator.nextUniform()
        let angle = CGFloat.pi * 2 * CGFloat(firstRot)
        let velocity = size / CGFloat(total) * CGFloat(generator.nextUniform()) + (CGFloat(i) * size / CGFloat(total))
        
        let tx = cos(angle) * velocity
        let ty = sin(angle) * velocity
        
        // Third random is a shape rotation on top of all of that.
        let secondRot = generator.nextUniform()
        let rot = (firstRot * 360.0) + secondRot * 180.0
        
        let fill = generateColor(from: remainingColors, generator: generator)
        
        ctx.translateBy(x: tx, y: ty)
        ctx.rotate(by: CGFloat(rot))
        ctx.setFillColor(fill)
        
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        ctx.fill(rect)
        
        // finish
        ctx.restoreGState()
    }
    
    private static func generateColor(
        from remainingColors: [UIColor],
        generator: GKMersenneTwisterRandomSource
    ) -> CGColor {
        let idx = floor(Float(remainingColors.count) * generator.nextUniform())
        return remainingColors[Int(idx)].cgColor
    }
    
    private static func hueShift(
        colors: [UIColor],
        generator: GKMersenneTwisterRandomSource
    ) -> [UIColor]{
        var amount = (generator.nextInt() * 30) - (wobble / 2)
        amount = abs(amount)
        return colors.map { $0.rotated(degrees: amount) }
    }
}
