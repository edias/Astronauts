//
//  AstronaultViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import Combine
import Foundation

class AstronautDetailsViewModel: ErrorHandlerPublisher {
    
    @Published
    private (set) var astronault: AstronautDetailsDataModel = astronaultDetailsPlaceHolder
    
    private var astronautsFetcher: AstronautsFetcher
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(_ astronautsFetcher: AstronautsFetcher = AstronautsNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
    }
    
    func loadAstronaultDetails(_ id: Int) {
        
        astronautsFetcher.fetchAstronautDetails(id).receive(on: RunLoop.main).sink { [weak self] data in
            guard case .failure(_) = data else { return }
            self?.handleError(data)
        }receiveValue: { [weak self] astronault in
            self?.astronault = astronault.makeDetailsViewModel()
        }.store(in: &subscriptions)
    }
    
    private static var astronaultDetailsPlaceHolder: AstronautDetailsDataModel {
        
        let gridValues = (dateOfBirth: "10-10-2002", status: "Retired", flights: "2")
        
        return AstronautDetailsDataModel(id: 0,
                                          name: "Astronaut Name",
                                          nationality: "Nationality",
                                          bio: "Alias alias cumque. Voluptatem ipsa repudiandae ipsum reiciendis illo. Incidunt rerum id architecto doloribus.",
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
