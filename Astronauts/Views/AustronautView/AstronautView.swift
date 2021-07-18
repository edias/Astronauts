//
//  AstronautView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautView: View {
    
    @ObservedObject
    private var viewModel = AstronautViewModel()
    
    var astronautId: Int
    
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
                    ThumbnailView(viewModel.astronault.profileImageThumbnail)
                        .foregroundColor(Color.red)
                        .frame(width: thumbnailSize, height: thumbnailSize)
                }
                
                Text(viewModel.astronault.name)
                    .tracking(1)
                    .foregroundColor(.black).opacity(0.8)
                    .font(.system(size: 22, weight: .semibold, design: .default))
                
                Text(viewModel.astronault.nationality)
                    .foregroundColor(.black).opacity(0.4)
                    .font(.system(size: 12, weight: .regular, design: .default))
                
                Spacer().frame(height: 20)
                
                Rectangle()
                    .frame(width: 50, height: 1)
                    .foregroundColor(.black).opacity(0.2)
                
                Spacer().frame(height: 20)
                
                AstronautGridView()
                
                Spacer().frame(height: 20)
                
                Text(viewModel.astronault.bio)
                    .foregroundColor(.black).opacity(0.4)
                    .padding(.horizontal, 15)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .lineSpacing(5)
                
            }.offset(y: -55)
            
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear { viewModel.loadAstronaultDetails(astronautId) }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautView(astronautId: 0)
            .previewLayout(.fixed(width: 400, height: 800))
    }
}
