//
//  AstronautsListViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation

import Combine
import Foundation

class AstronautsListViewModel: ObservableObject {
    
    @Published
    private (set) var astronauts: [Astronaut] = []
    
    private var susbcriptions = Set<AnyCancellable>()
    
    private var astronautsFetcher: AustronautsFetcher
    
    init(_ astronautsFetcher: AustronautsFetcher = AstronautNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
    }
    
    func loadAstronaults() {
        
        astronautsFetcher.fetchAustronauts().receive(on: RunLoop.main).sink { _ in }
            receiveValue: { [weak self] astronauts in
            self?.astronauts = astronauts
        }.store(in: &susbcriptions)
    }
}
