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
    private (set) var isAstronautsLoaded = false
    
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
        
        initializePlaceHolders()
        
        astronautsFetcher.fetchAstronauts().receive(on: RunLoop.main).sink { [weak self] data in
            guard case .failure(_) = data else { return }
            self?.handleError(data)
        } receiveValue: { [weak self] astronauts in
            self?.astronauts = astronauts.map { $0.makeRollDataModel() }.sorted(by: <)
            guard !astronauts.isEmpty else { return }
            self?.isAstronautsLoaded = true
        }.store(in: &susbcriptions)
    }
    
    private func setupSortingSubscription() {
        
        $isSortingAscendent.receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isAscendent in
                isAscendent ? self?.astronauts.sort(by: <) : self?.astronauts.sort(by: >)
            }).store(in: &susbcriptions)
    }
    
    private func initializePlaceHolders() {
        isAstronautsLoaded = false
        astronauts = MockBuilder.makeAstronauts()
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


class MockBuilder {
    
    static func makeAstronauts() -> [AstronautRollDataModel] {
        (0...11).map { _ -> AstronautRollDataModel in
            AstronautRollDataModel(id: 0,
                                   name: "Astronaut Name",
                                   nationality: "Nationality",
                                   imageUrl: "",
                                   colors: [])
        }
    }
}
