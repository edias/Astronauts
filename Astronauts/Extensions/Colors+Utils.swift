//
//  Colors+Utils.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

extension Color {
    
    static var randomGradient: [Color] {
        let firstColor = random
        let firstUIColor = UIColor(cgColor: firstColor.cgColor!)
        let secondColor = complementarColor(forColor: firstUIColor)
        return [firstColor, secondColor]
    }
    
    static var random: Color {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return Color(color)
    }
    
    static func complementarColor(forColor color: UIColor) -> Color {
        
        let ciColor = CIColor(color: color)
        
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        let color =  UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: ciColor.alpha)
        return Color(color)
    }
}
