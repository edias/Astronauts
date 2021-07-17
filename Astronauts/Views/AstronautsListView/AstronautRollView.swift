//
//  AstronautRollView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautRollView: View {
    
    private var astronaut: Astronaut

    init(_ astronaut: Astronaut) {
        self.astronaut = astronaut
    }

    var body: some View {
        
        HStack {
            ThumbnailView(astronaut.profileImageThumbnail)
                .frame(width: 80, height: 80)
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
    
    private static var astronaut = Astronaut(name: "Joe", nationality: "AUS", profileImageThumbnail: "")
    
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
