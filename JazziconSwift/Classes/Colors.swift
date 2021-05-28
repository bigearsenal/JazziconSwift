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
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func rotated(degrees: CGFloat) -> UIColor {
        var hue = CGFloat(0)
        var saturation = CGFloat(0)
        var brightness = CGFloat(0)
        var alpha = CGFloat(0)
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        hue = fmod(hue + degrees/360.0, 1.0)
        if hue < 0 {hue += 1}
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}
