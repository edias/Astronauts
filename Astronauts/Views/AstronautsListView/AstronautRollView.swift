//
//  AstronautRollView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautRollView: View {
    
    private var astronaut: AstronautRollDataModel

    init(_ astronaut: AstronautRollDataModel) {
        self.astronaut = astronaut
    }

    var body: some View {
        
        HStack {
            
            ThumbnailView(urlString: astronaut.imageUrl, gradientColors: astronaut.colors)
                .frame(width: 50, height: 50)
                .padding(.leading, 10)
                .padding(.trailing, 2)
                .padding(.vertical, 8)
            
            VStack (alignment: .leading){
                Text(astronaut.name)
                    .font(.callout)
                Text(astronaut.nationality)
                    .font(.caption)
            }
            
            Spacer()
        }
    }
}

struct AstronautRollView_Previews: PreviewProvider {
    
    private static var astronaut = AstronautRollDataModel(id: 0,
                                                          name: "Joe",
                                                          nationality: "AUS",
                                                          imageUrl: "",
                                                          colors: [])
    static var previews: some View {
        Group {
            AstronautRollView(astronaut)
                .previewLayout(.fixed(width: 350, height: 80))
                .previewDisplayName("Light Mode")
            
            AstronautRollView(astronaut)
                .previewLayout(.fixed(width: 350, height: 80))
                .preferredColorScheme(.dark)
        }
    }
}
