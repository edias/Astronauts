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
    
    init(_ urlString: String) {
        self.imageLoader.loadImage(urlString)
    }
    
    var body: some View {
        
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .onReceive(imageLoader.$image) { image in
                guard let image = image else { return }
                self.uiImage = image
            }
    }
}

//struct ThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailView()
//    }
//}
