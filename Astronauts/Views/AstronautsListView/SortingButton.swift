//
//  SortingButton.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import SwiftUI

struct SortingButton: View {
    
    @Binding
    var isAscendent: Bool
    
    var body: some View {
        Button(action: { isAscendent.toggle() }) {
            HStack(spacing: 2) {
                Image(systemName: "arrow.down")
                    .resizable()
                    .frame(width: 12, height: 14)
                    .foregroundColor(.black)
                    .opacity(isAscendent ? 1 : 0.5)
                
                Image(systemName: "arrow.up")
                    .resizable()
                    .frame(width: 12, height: 14)
                    .foregroundColor(Color.black)
                    .opacity(isAscendent ? 0.5 : 1)
            }
        }
    }
}

struct SortingButton_Previews: PreviewProvider {
    static var previews: some View {
        SortingButton(isAscendent: .constant(true))
            .previewLayout(.fixed(width: 100, height: 50))
    }
}
