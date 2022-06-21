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
    
    /// Seed for generate random icon
    private var seed: UInt32
    
    // MARK: - Initializers
    
    /// Initalize Jazzicon
    public init(
        seed: UInt32 = .random(in: 0..<10000000)
    ) {
        self.seed = seed
    }
    
    /// Draw jazzicon in current context
    /// - Parameters:
    ///   - context: current context
    ///   - rect: rect to draw
    public func draw(
        with context: CGContext,
        in rect: CGRect
    ) {
        // create generator
        let generator = Gust(seed: seed)

        var remainingColors = hueShift(colors: jazziconColorHexes, rand: generator.randomFloat())
        
        // first shape (without translation, rotation)
        drawFirstShape(
            with: context,
            in: rect,
            remainingColors: &remainingColors,
            generator: generator
        )
        
        // other shapes
        let shapeCount = 4
        for i in 0..<shapeCount-1 {

            drawOtherShape(
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
private func drawFirstShape(
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

private func drawOtherShape(
    with ctx: CGContext,
    in rect: CGRect,
    total: Int,
    i: Int,
    remainingColors: inout [ColorHex],
    generator: Gust
) {
    let firstRot: Float = generator.randomFloat()
    let angle = Float.pi * 2 * Float(firstRot)

    let f = Float(rect.width) / Float(total) * generator.randomFloat()
    let s = (Float(i) * Float(rect.height) / Float(total))
    let velocity = f + s
    
    //1
    let tx = cos(angle) * velocity
    let ty = sin(angle) * velocity
        
    // Third random is a shape rotation on top of all of that.
    let secondRot: Float = generator.randomFloat()

    let rot = ((firstRot * 360)) + (secondRot * 180)

    // drawing
    ctx.saveGState()
    
    let fill = generateColor(from: &remainingColors, generator: generator)
    ctx.setFillColor(fill)
    
    ctx.translateBy(x: CGFloat(tx), y: CGFloat(ty))
    
    ctx.translateBy(x: CGFloat(rect.width/2), y: CGFloat(rect.height/2))
    ctx.rotate(by: CGFloat(rot) * CGFloat(Double.pi / 180))

    // Move
    let rect = CGRect(x: -rect.width/2, y: -rect.height/2, width: rect.width, height: rect.height)
    ctx.fill(rect)
//
    ctx.restoreGState()
}

private func generateColor(
    from remainingColors: inout [ColorHex],
    generator: Gust
) -> CGColor {
    // Temp bug fix to get correct numbers generated
    _ = generator.randomFloat()
    let r = generator.randomFloat()
    let idx = floor(Float(remainingColors.count) * r)
    let colorHex = remainingColors[Int(idx)]
    remainingColors.removeAll(where: {$0 == colorHex})
    return CGColor.from(hex: colorHex)
}

func hueShift(
    colors: [ColorHex],
    rand: Float
) -> [ColorHex]{
    let wobble: Float = 30
    let rand: Float = rand
    let amount = (rand * 30.0) - (wobble / 2)
    return colors.map {rotateColor($0, degrees: Float(amount))}
}


extension Gust {
    func randomFloat() -> Float {
        let uint32: UInt32 = random()
        return Float(uint32) * (1.0/4294967296.0)
    }
}
