//
//  Jazzicon.swift
//  JazziconSwift
//
//  Created by Chung Tran on 28/05/2021.
//

import Foundation
import CoreGraphics

public struct Jazzicon {
    // MARK: - Properties
    private var seed: UInt32
    
    // MARK: - Initializers
    public init(
        seed: UInt32 = .random(in: 0..<10000000)
    ) {
        self.seed = seed
    }
    
    /// Generate random jazzicon
    /// - Parameter size: size of the image (width = height)
    /// - Returns: an instance of UIImage
    public func generateImage(context: CGContext, rect: CGRect) {
        // create generator
        let generator = Gust(seed: seed)
        
        var remainingColors = hueShift(colors: jazziconColorHexes, generator: generator)
        
        // first shape (without translation, rotation)
        
        generateFirstShape(
            with: context,
            in: rect,
            remainingColors: &remainingColors,
            generator: generator
        )
        
        // other shapes
        
        let shapeCount = 4
        for i in 0..<shapeCount-1 {
            generateOtherShape(
                with: context,
                in: rect,
                total: shapeCount-1,
                i: i,
                remainingColors: &remainingColors,
                generator: generator
            )
        }
    }
}

// MARK: - Helpers
private func generateFirstShape(
    with ctx: CGContext,
    in rect: CGRect,
    remainingColors: inout [ColorHex],
    generator: Gust
) {
    // drawing
    ctx.saveGState()
    ctx.setFillColor(generateColor(from: &remainingColors, generator: generator))
    ctx.fill(rect)
    ctx.restoreGState()
}

private func generateOtherShape(
    with ctx: CGContext,
    in rect: CGRect,
    total: Int,
    i: Int,
    remainingColors: inout [ColorHex],
    generator: Gust
) {
    let firstRot = generator.randomDouble()
    let angle = Double.pi * 2 * Double(firstRot)
    
    let velocity = Double(rect.width) / Double(total) * generator.randomDouble() + (Double(i) * Double(rect.width) / Double(total))
    
    let tx = cos(angle) * velocity
    let ty = sin(angle) * velocity
    
    // Third random is a shape rotation on top of all of that.
    let secondRot = generator.randomDouble()
    let rot = (firstRot * 2 * .pi) + secondRot * .pi
    
    // drawing
    ctx.saveGState()
    
    let fill = generateColor(from: &remainingColors, generator: generator)
    ctx.setFillColor(fill)
    ctx.rotate(by: -CGFloat(rot.toFixed(1)))
    ctx.translateBy(x: -CGFloat(tx), y: -CGFloat(ty))
    
    // Move
    ctx.fill(rect)
    
    ctx.restoreGState()
}

private func generateColor(
    from remainingColors: inout [ColorHex],
    generator: Gust
) -> CGColor {
    let idx = floor(Double(remainingColors.count) * generator.randomDouble())
    let colorHex = remainingColors[Int(idx)]
    return .from(hex: colorHex)? ?? .init(gray: 0, alpha: 1)
}

func hueShift(
    colors: [ColorHex],
    generator: Gust
) -> [ColorHex]{
    let wobble: Double = 30
    let random = generator.randomDouble()
    let amount = (random * 30.0) - (wobble / 2)
    return colors.map {rotateColor($0, degrees: amount)}
}


extension Gust {
    func randomDouble() -> Double {
        let uint32: UInt32 = random()
        print(uint32)
        return Double(uint32) / 4294967296.0
    }
}
