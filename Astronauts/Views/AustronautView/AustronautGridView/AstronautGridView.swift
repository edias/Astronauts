//
//  AstronautGridView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautGridView: View {
    
    var body: some View {
        
        HStack {
            AstronautGridCellView()
            AstronautGridCellDivider()
            AstronautGridCellView()
            AstronautGridCellDivider()
            AstronautGridCellView()
        }.border(Color.gray.opacity(0.2))
    }
}

struct AstronautInfoGridView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautGridView()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
