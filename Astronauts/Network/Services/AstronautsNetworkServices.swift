//
//  AstronautsNetworkServices.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Combine
import Foundation

protocol AstronautsFetcher {
    func fetchAstronauts() -> AnyPublisher<[Astronaut], Error>
    func fetchAstronautImage(_ urlString: String) -> AnyPublisher<Data, Error>
    func fetchAstronautDetails(_ id: Int) -> AnyPublisher<AstronautDetails, Error>
}

class AstronautsNetworkServices: BaseNetworkServices, AstronautsFetcher {
    
    func fetchAstronauts() -> AnyPublisher<[Astronaut], Error> {
        
        let astronautsResultPublisher: AnyPublisher<AstronautsResult, Error> = get(urlString: "\(Environment.URLS.base)/api/3.5.0/astronaut/?format=json")
        
        return astronautsResultPublisher.flatMap { astronautsResult in
            Just(astronautsResult.results)
        }.eraseToAnyPublisher()
    }
    
    func fetchAstronautImage(_ urlString: String) -> AnyPublisher<Data, Error> {
        get(imageUrlString: urlString)
    }
    
    func fetchAstronautDetails(_ id: Int) -> AnyPublisher<AstronautDetails, Error> {
        get(urlString: "\(Environment.URLS.base)/api/3.5.0/astronaut/\(id)?format=json")
    }
}
