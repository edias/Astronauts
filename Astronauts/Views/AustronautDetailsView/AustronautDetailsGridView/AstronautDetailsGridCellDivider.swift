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
            .foregroundColor(.black.opacity(0.2))
            .frame(width: 0.5, height: 50)
    }
}

struct AstronautInfoGridCellDivider_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetailsGridCellDivider()
    }
}
