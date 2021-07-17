//
//  AstronautView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautView: View {
    
    private let thumbnailSize: CGFloat = 80
    
    var body: some View {
        
        VStack {
            
            Rectangle()
                .frame(height: 140)
            
            VStack {
                
                ZStack {
                    Circle()
                        .frame(width: thumbnailSize + 7, height: thumbnailSize + 7)
                        .foregroundColor(.white)
                    ThumbnailView("")
                        .foregroundColor(Color.red)
                        .frame(width: thumbnailSize, height: thumbnailSize)
                }
                
                Text("Kevin R. Kregel")
                    .tracking(1)
                    .foregroundColor(.black).opacity(0.8)
                    .font(.system(size: 22, weight: .semibold, design: .default))
                
                Text("American")
                    .foregroundColor(.black).opacity(0.4)
                    .font(.system(size: 12, weight: .regular, design: .default))
                
                Spacer().frame(height: 20)
                
                Rectangle()
                    .frame(width: 50, height: 1)
                    .foregroundColor(.black).opacity(0.2)
                
                Spacer().frame(height: 20)
                
                AstronautGridView()
                
                Spacer().frame(height: 20)
                
                Text("Jennifer Sidey-Gibbons hails from Calgary, Alberta. She holds an honors bachelor's degree in mechanical engineering from McGill University in Montreal and a doctorate in engineering from the University of Cambridge. While at McGill, she conducted research on flame propagation in microgravity, in collaboration with CSA and the National Research Council Flight Research Laboratory. Prior to joining CSA, Sidey-Gibbons worked as an assistant professor in combustion in the Department of Engineering at Cambrid.")
                    .foregroundColor(.black).opacity(0.4)
                    .padding(.horizontal, 15)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .lineSpacing(5)
                
                Spacer()
                
            }.offset(y: -55)
            
            Spacer()
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautView()
            .previewLayout(.fixed(width: 400, height: 600))
    }
}
