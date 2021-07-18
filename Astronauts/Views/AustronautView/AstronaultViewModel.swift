//
//  AstronaultViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import Combine
import Foundation

class AstronautViewModel: ObservableObject {
    
    @Published
    private (set) var astronault: AstronautDetails = astronaultDetailsPlaceHolder
    
    private var astronautsFetcher: AustronautsFetcher
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(_ astronautsFetcher: AustronautsFetcher = AstronautsNetworkServices()) {
        self.astronautsFetcher = astronautsFetcher
    }
    
    func loadAstronaultDetails(_ id: Int) {
        
        astronautsFetcher.fetchAstronautDetails(id).receive(on: RunLoop.main).sink { _ in }
            receiveValue: { [weak self] astronault in
                self?.astronault = astronault
            }.store(in: &subscriptions)
    }
    
    private static var astronaultDetailsPlaceHolder: AstronautDetails {
        AstronautDetails(id: 0,
                         name: "",
                         nationality: "",
                         bio: "",
                         dateOfBirth: "",
                         profileImageThumbnail: "",
                         flights: [])
    }
}
