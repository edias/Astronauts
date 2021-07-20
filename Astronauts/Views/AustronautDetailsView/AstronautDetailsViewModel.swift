//
//  AstronautDetailsViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import Combine
import Foundation

class AstronautDetailsViewModel: ErrorHandlerPublisher {
    
    @Published
    private (set) var isAstronautsDetailsLoaded = false
    
    @Published
    private (set) var astronaut: AstronautDetailsDataModel = astronautDetailsPlaceHolder
    
    private var astronautsFetcher: AstronautsFetcher
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(_ astronautsFetcher: AstronautsFetcher = AstronautsNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
    }
    
    func loadAstronautDetails(_ id: Int) {
        
        astronautsFetcher.fetchAstronautDetails(id).receive(on: RunLoop.main).sink { [weak self] data in
            guard case .failure(_) = data else { return }
            self?.handleError(data)
        } receiveValue: { [weak self] astronaut in
            self?.astronaut = astronaut.makeDetailsViewModel()
            self?.isAstronautsDetailsLoaded = true
            self?.errorType = nil
        }.store(in: &subscriptions)
    }
    
    private static var astronautDetailsPlaceHolder: AstronautDetailsDataModel {
        
        let gridValues = (dateOfBirth: "10-10-2002", status: "Retired", flights: "2")
        
        return AstronautDetailsDataModel(id: 0,
                                          name: "Astronaut Name",
                                          nationality: "Nationality",
                                          bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                          imageUrl: "",
                                          gridValues: gridValues)
    }
}

private extension AstronautDetails {
    func makeDetailsViewModel() -> AstronautDetailsDataModel {
        let gridValues = (dateOfBirth: dateOfBirth, status: status.name, flights: "\(flights.count)")
        return AstronautDetailsDataModel(id: id,
                                          name: name,
                                          nationality: nationality,
                                          bio: bio,
                                          imageUrl: profileImageThumbnail,
                                          gridValues: gridValues)
    }
}
