//
//  AstronautsListViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation
import Combine

class AstronautsListViewModel: ErrorHandlerPublisher {
    
    @Published
    var isSortingAscendent: Bool = true
    
    @Published
    private (set) var astronauts: [Astronaut] = []
    
    private var susbcriptions = Set<AnyCancellable>()
    
    private var astronautsFetcher: AstronautsFetcher
    
    init(_ astronautsFetcher: AstronautsFetcher = AstronautsNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
        super.init()
        setupSortingSubscription()
    }
    
    func loadAstronauts() {
        
        astronautsFetcher.fetchAstronauts().receive(on: RunLoop.main).sink { [weak self] data in
            guard case .failure(_) = data else { return }
            self?.handleError(data)
        } receiveValue: { [weak self] astronauts in
            self?.astronauts = astronauts.sorted(by: <)
        }.store(in: &susbcriptions)
    }
    
    private func setupSortingSubscription() {
        
        $isSortingAscendent.receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isAscendent in
                isAscendent ? self?.astronauts.sort(by: <) : self?.astronauts.sort(by: >)
            }).store(in: &susbcriptions)
    }
}
