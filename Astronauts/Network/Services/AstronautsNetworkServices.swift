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
    func fetchImage(_ urlString: String) -> AnyPublisher<Data, Error>
}

class AstronautsNetworkServices: BaseNetworkServices, AustronautsFetcher {
    
    func fetchAustronauts() -> AnyPublisher<[Astronaut], Error> {
        
        let astronautsResultPublisher: AnyPublisher<AstronautsResult, Error> = get(urlString: "\(Environment.URLS.base)/api/3.5.0/astronaut/?format=json")
        
        return astronautsResultPublisher.flatMap { astronautsResult in
            Just(astronautsResult.results)
        }.eraseToAnyPublisher()
    }
    
    func fetchImage(_ urlString: String) -> AnyPublisher<Data, Error> {
        get(imageUrlString: urlString)
    }
}
