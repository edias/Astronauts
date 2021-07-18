//
//  AstronautsListViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation
import Combine
import SwiftUI

class AstronautsListViewModel: ErrorHandlerPublisher {
    
    @Published
    var isSortingAscendent: Bool = true
    
    @Published
    private (set) var astronauts: [AstronautRollDataModel] = []
    
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
            self?.astronauts = astronauts.map { $0.makeRollDataModel() }.sorted(by: <)
        }.store(in: &susbcriptions)
    }
    
    private func setupSortingSubscription() {
        
        $isSortingAscendent.receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isAscendent in
                isAscendent ? self?.astronauts.sort(by: <) : self?.astronauts.sort(by: >)
            }).store(in: &susbcriptions)
    }
}

private extension Astronaut {
    func makeRollDataModel() -> AstronautRollDataModel {
        AstronautRollDataModel(id: id,
                               name: name,
                               nationality: nationality,
                               imageUrl: profileImageThumbnail,
                               colors: Color.randomGradient)
    }
}
