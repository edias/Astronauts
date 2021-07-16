//
//  AstronautNetworkService.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Combine
import Foundation

protocol AustronautsFetcher {
    func fetchAustronauts() -> AnyPublisher<[Astronaut], Error>
}

class AstronautNetworkServices: BaseNetworkServices, AustronautsFetcher {
    
    func fetchAustronauts() -> AnyPublisher<[Astronaut], Error> {
        
        let astronautsResultPublisher: AnyPublisher<AstronautsResult, Error> = get(url: "\(Environment.URLS.base)/api/3.5.0/astronaut/?format=json")
        
        return astronautsResultPublisher.flatMap { astronautsResult in
            Just(astronautsResult.results)
        }.eraseToAnyPublisher()
    }
}


struct Environment {
    
    enum URLS: String {
        case base = "https://spacelaunchnow.me"
    }
}

extension Environment.URLS: CustomStringConvertible {
    var description: String { rawValue }
}
