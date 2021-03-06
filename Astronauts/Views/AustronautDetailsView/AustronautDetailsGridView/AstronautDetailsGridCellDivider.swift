//
//  AstronautInfoGridCellDivider.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautDetailsGridCellDivider: View {
    var body: some View {
        Rectangle()
            .foregroundColor(ColorPalette.secondaryColor)
            .frame(width: 1, height: 60)
    }
}

struct AstronautInfoGridCellDivider_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetailsGridCellDivider()
    }
}
