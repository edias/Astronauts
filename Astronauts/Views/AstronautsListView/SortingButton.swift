//
//  SortingButton.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import SwiftUI

struct SortingButton: View {
    
    @Binding
    var isSortingAscendent: Bool
    
    var body: some View {
        Button(action: { isSortingAscendent.toggle() }) {
            HStack(spacing: 2) {
                Image(systemName: "arrow.down")
                    .resizable()
                    .frame(width: 12, height: 14)
                    .foregroundColor(ColorPalette.primaryContrastColor)
                    .opacity(isSortingAscendent ? 1 : 0.5)
                
                Image(systemName: "arrow.up")
                    .resizable()
                    .frame(width: 12, height: 14)
                    .foregroundColor(ColorPalette.primaryContrastColor)
                    .opacity(isSortingAscendent ? 0.5 : 1)
            }
        }
    }
}

struct SortingButton_Previews: PreviewProvider {
    static var previews: some View {
        SortingButton(isSortingAscendent: .constant(true))
            .previewLayout(.fixed(width: 100, height: 50)).previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}
