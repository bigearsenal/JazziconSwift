//
//  Colors.swift
//  JazziconSwift
//
//  Created by Chung Tran on 28/05/2021.
//

import Foundation

extension UIColor {
    static var jazziconColors: [UIColor] {
        colorHexes.map {UIColor(hex: $0)!}
    }
    
    private static var colorHexes: [String] {
        [
            "#01888C", // teal
            "#FC7500", // bright orange
            "#034F5D", // dark teal
            "#F73F01", // orangered
            "#FC1960", // magenta
            "#C7144C", // raspberry
            "#F3C100", // goldenrod
            "#1598F2", // lightning blue
            "#2465E1", // sail blue
            "#F19E02", // gold
        ]
    }
    
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    func rotated(degrees: Int) -> UIColor {
        var hue = CGFloat(0)
        var saturation = CGFloat(0)
        var brightness = CGFloat(0)
        var alpha = CGFloat(0)
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        hue = fmod(hue + CGFloat(degrees)/360.0, 1.0)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}
