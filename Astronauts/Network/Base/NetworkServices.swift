//
//  NetworkService.swift
//  Astronauts
//
//  Created by Eduardo Dias on 12/07/21.
//

import Combine
import Foundation

typealias RequestResult = (data: Data, response: URLResponse)

extension URLSession: RestClient {
    func performRequest(_ request: URLRequest) -> AnyPublisher<RequestResult, URLError> {
        URLSession.shared.dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

protocol RestClient {
    func performRequest(_ request: URLRequest) -> AnyPublisher<RequestResult, URLError>
}

enum NetworkServiceError: Error {
    case invalidURL
}

protocol NetworkServices {
    var restClient: RestClient { get }
    func get<T: Decodable>(url: String) -> AnyPublisher<T, Error>
}

extension NetworkServices {
    
    func get<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: url) else {
            return Fail<T, Error>(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return restClient.performRequest(request)
                   .tryMap { output in try NetworkStatusHandler.handleOutput(output).data }
                   .tryMap { output in try Serializer.shared.deserialize(T.self, data: output) }
                   .eraseToAnyPublisher()
    }
}

class BaseNetworkServices: NetworkServices {
    var restClient: RestClient { URLSession.shared }
}
