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
    
    private var astronautsFetcher: AustronautsFetcher
    
    init(astronautsFetcher: AustronautsFetcher = AstronautsNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
    }
    
    func loadImage(_ urlString: String) {
        
        cancellable = astronautsFetcher.fetchImage(urlString)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            receiveValue: { [weak self] data in
                self?.image = UIImage(data: data)
        }
    }
}