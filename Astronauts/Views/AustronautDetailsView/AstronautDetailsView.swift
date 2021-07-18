//
//  AstronautView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautDetailsView: View {
    
    @ObservedObject
    private var viewModel = AstronautDetailsViewModel()
    
    var astronautId: Int
    var colors: [Color]
    
    private let thumbnailSize: CGFloat = 80
    private let thumbnailGap: CGFloat = 7
    
    var body: some View {
        
        VStack {
            
            Rectangle()
                .fill(ColorPalette.primaryComplementaryColor)
                .frame(height: 140)
            
            VStack {
                
                ZStack {
                    Circle()
                        .frame(width: thumbnailSize + thumbnailGap, height: thumbnailSize + thumbnailGap)
                        .foregroundColor(ColorPalette.primaryColor)
                    ThumbnailView(urlString: viewModel.astronaut.imageUrl, gradientColors: colors)
                        .frame(width: thumbnailSize, height: thumbnailSize)
                }
                .unredacted(when: viewModel.isAstronautsDetailsLoaded)
                
                Text(viewModel.astronaut.name)
                    .tracking(1)
                    .foregroundColor(ColorPalette.primaryContrastColor)
                    .font(.system(size: 22, weight: .semibold, design: .default))
                    .unredacted(when: viewModel.isAstronautsDetailsLoaded)
                
                Text(viewModel.astronaut.nationality)
                    .foregroundColor(ColorPalette.tertiaryColor)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .unredacted(when: viewModel.isAstronautsDetailsLoaded)
                
                Spacer().frame(height: 20)
                
                Rectangle()
                    .frame(width: 50, height: 1)
                    .foregroundColor(ColorPalette.secondaryColor)
                
                Spacer().frame(height: 25)
                
                AstronautDetailsGridView(gridValues: viewModel.astronaut.gridValues)
                    .unredacted(when: viewModel.isAstronautsDetailsLoaded)
                
                Spacer().frame(height: 20)
                
                Text(viewModel.astronaut.bio)
                    .foregroundColor(ColorPalette.tertiaryColor)
                    .padding(.horizontal, 15)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .lineSpacing(5)
                    .unredacted(when: viewModel.isAstronautsDetailsLoaded)
                
            }.offset(y: -55)
            
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear { viewModel.loadAstronautDetails(astronautId) }
        .onError(viewModel.errorType, retryAction: { viewModel.loadAstronautDetails(astronautId) })
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetailsView(astronautId: 0, colors: [])
            .previewLayout(.fixed(width: 400, height: 800))
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}
