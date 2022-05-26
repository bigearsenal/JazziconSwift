//
//  Jazzicon.swift
//  JazziconSwift
//
//  Created by Chung Tran on 28/05/2021.
//

import Foundation
import GameplayKit
import UIKit

public struct Jazzicon {
    // MARK: - Properties
    private var seed: UInt64
    
    // MARK: - Initializers
    public init(
        seed: UInt64 = .random(in: 0..<10000000)
    ) {
        self.seed = seed
    }
    
    /// Generate random jazzicon
    /// - Parameter size: size of the image (width = height)
    /// - Returns: an instance of UIImage
    public func generateImage(size: CGFloat) -> UIImage {
        // create generator
        let generator = GKMersenneTwisterRandomSource(seed: seed)
        
        var remainingColors = hueShift(colors: jazziconColorHexes, generator: generator)
        
        var images = [UIImage]()
        
        // first shape (without translation, rotation)
        
        let firstImg = generateFirstShape(
            size: size,
            remainingColors: &remainingColors,
            generator: generator
        )
        images.append(firstImg)
        
        // other shapes
        let shapeCount = 4
        for i in 0..<shapeCount-1 {
            let nextImg = generateOtherShape(
                size: size,
                total: shapeCount-1,
                i: i,
                remainingColors: &remainingColors,
                generator: generator
            )
            images.append(nextImg)
        }
        
        UIGraphicsBeginImageContext(.init(width: size, height: size))
        let areaSize = CGRect(x: 0, y: 0, width: size, height: size)
        
        images.forEach {$0.draw(in: areaSize)}
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

// MARK: - Helpers
private func generateFirstShape(
    size: CGFloat,
    remainingColors: inout [ColorHex],
    generator: GKMersenneTwisterRandomSource
) -> UIImage {
    // drawing
    UIGraphicsBeginImageContextWithOptions(.init(width: size, height: size), false, 0)
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.saveGState()
    
    let rect = CGRect(x: 0, y: 0, width: size, height: size)
    ctx.setFillColor(generateColor(from: &remainingColors, generator: generator))
    ctx.fill(rect)
    ctx.restoreGState()
    let img = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return img
}

private func generateOtherShape(
    size: CGFloat,
    total: Int,
    i: Int,
    remainingColors: inout [ColorHex],
    generator: GKMersenneTwisterRandomSource
) -> UIImage {
    let firstRot = generator.nextUniform()
    let angle = Float.pi * 2 * Float(firstRot)
    
    let velocity = Float(size) / Float(total) * generator.nextUniform() + (Float(i) * Float(size) / Float(total))
    
    let tx = cos(angle) * velocity
    let ty = sin(angle) * velocity
    
    // Third random is a shape rotation on top of all of that.
    let secondRot = generator.nextUniform()
    let rot = (firstRot * 2 * .pi) + secondRot * .pi
    
    // drawing
    UIGraphicsBeginImageContextWithOptions(.init(width: size, height: size), false, 0)
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.saveGState()
    
    let fill = generateColor(from: &remainingColors, generator: generator)
    ctx.setFillColor(fill)
    
    ctx.rotate(by: -CGFloat(rot))
    ctx.translateBy(x: -CGFloat(tx), y: -CGFloat(ty))
    
    // Move
    let rect = CGRect(x: 0, y: 0, width: size, height: size)
    ctx.fill(rect)
    
    ctx.restoreGState()
    let img = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return img
}

private func generateColor(
    from remainingColors: inout [ColorHex],
    generator: GKMersenneTwisterRandomSource
) -> CGColor {
    let idx = floor(Float(remainingColors.count) * generator.nextUniform())
    let colorHex = remainingColors[Int(idx)]
    remainingColors.removeAll(where: {$0 == colorHex})
    return UIColor(hex: colorHex)?.cgColor ?? UIColor.white.cgColor
}

private func hueShift(
    colors: [ColorHex],
    generator: GKMersenneTwisterRandomSource
) -> [ColorHex]{
    let wobble: Double = 30
    let amount = (Double(generator.nextUniform()) * 30.0) - (wobble / 2)
    return colors.map {rotateColor($0, degrees: amount)}
}
