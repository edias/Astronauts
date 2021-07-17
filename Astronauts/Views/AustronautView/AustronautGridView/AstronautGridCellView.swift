//
//  AstronautInfoGridCellView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautGridCellView: View {
    
    var body: some View {
        VStack (spacing: 5){
            Text("10/08/90")
                .foregroundColor(.black).opacity(0.8)
                .font(.system(size: 14, weight: .bold, design: .default))
            Text("Date of Birth")
                .foregroundColor(.black).opacity(0.4)
                .font(.system(size: 11, weight: .semibold, design: .default))

        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct AstronautGridCellView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautGridCellView()
    }
}
