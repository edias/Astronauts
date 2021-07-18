//
//  AstronautGridView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautDetailsGridView: View {
    
    var body: some View {
        
        HStack {
            AstronautDetailsGridCellView()
            AstronautDetailsGridCellDivider()
            AstronautDetailsGridCellView()
            AstronautDetailsGridCellDivider()
            AstronautDetailsGridCellView()
        }.border(Color.gray.opacity(0.2))
    }
}

struct AstronautInfoGridView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetailsGridView()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
