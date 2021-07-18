//
//  AstronautsListViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation
import Combine

class AstronautsListViewModel: ObservableObject {
    
    @Published
    private (set) var astronauts: [Astronaut] = []
    
    private var susbcriptions = Set<AnyCancellable>()
    
    private var astronautsFetcher: AstronautsFetcher
    
    init(_ astronautsFetcher: AstronautsFetcher = AstronautsNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
    }
    
    func loadAstronauts() {
        
        astronautsFetcher.fetchAstronauts().receive(on: RunLoop.main).sink { _ in }
            receiveValue: { [weak self] astronauts in
            self?.astronauts = astronauts
        }.store(in: &susbcriptions)
    }
}
