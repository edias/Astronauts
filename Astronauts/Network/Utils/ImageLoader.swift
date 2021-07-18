//
//  ImageLoader.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Combine
import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published
    private (set) var image: UIImage?
        
    private var cancellable: AnyCancellable?
    
    private var astronautsFetcher: AstronautsFetcher
    
    init(astronautsFetcher: AstronautsFetcher = AstronautsNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
    }
    
    func loadImage(_ urlString: String) {
        
        cancellable = astronautsFetcher.fetchAstronautImage(urlString)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            receiveValue: { [weak self] data in
                self?.image = UIImage(data: data)
        }
    }
}
