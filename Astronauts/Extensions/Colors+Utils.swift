//
//  Colors+Utils.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let uiColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return Color(uiColor)
    }
}
