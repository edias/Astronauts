//
//  ThumbnailView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct ThumbnailView: View {
    
    @State
    private var uiImage = UIImage(named: "Placeholder")!
    
    @ObservedObject
    private var imageLoader = ImageLoader()
    
    private var gradientColors: [Color]
    
    init(urlString: String, gradientColors: [Color]) {
        self.gradientColors = gradientColors
        self.imageLoader.loadImage(urlString)
    }
    
    var body: some View {
        
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(Circle())
            .padding(3)
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(gradient:
                                        Gradient(colors: gradientColors),
                                       startPoint: .leading, endPoint: .trailing),
                        lineWidth: 2)
            )
            .onReceive(imageLoader.$image) { image in
                guard let image = image else { return }
                self.uiImage = image
            }
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(urlString:"", gradientColors: [])
    }
}
