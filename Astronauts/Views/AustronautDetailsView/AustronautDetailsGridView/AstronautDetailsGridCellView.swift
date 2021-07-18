//
//  AstronautInfoGridCellView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautDetailsGridCellView: View {
    
    var value: String
    var label: String
    
    var body: some View {
        VStack (spacing: 5){
            Text(value)
                .foregroundColor(.black).opacity(0.8)
                .font(.system(size: 14, weight: .bold, design: .default))
            Text(label)
                .foregroundColor(.black).opacity(0.4)
                .font(.system(size: 11, weight: .semibold, design: .default))

        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct AstronautGridCellView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetailsGridCellView(value: "Date of Birth", label: "10-10-2005")
    }
}
