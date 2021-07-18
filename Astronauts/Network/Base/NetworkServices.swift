//
//  NetworkServices.swift
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
    func get<T: Decodable>(urlString: String) -> AnyPublisher<T, Error>
    func get(imageUrlString: String) -> AnyPublisher<Data, Error>
}

extension NetworkServices {
    
    func get<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        
        guard let request = makeURLRequest(urlString) else {
            return Fail<T, Error>(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }
                
        return restClient.performRequest(request)
                   .tryMap { output in try NetworkStatusHandler.handleOutput(output).data }
                   .tryMap { output in try Serializer.shared.deserialize(T.self, data: output) }
                   .eraseToAnyPublisher()
    }
    
    func get(imageUrlString: String) -> AnyPublisher<Data, Error> {
        
        guard let request = makeURLRequest(imageUrlString) else {
            return Fail<Data, Error>(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }
                
        return restClient.performRequest(request)
            .tryMap { output in output.data  }
            .eraseToAnyPublisher()
    }
    
    private func makeURLRequest(_ urlString: String) -> URLRequest? {
        
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}

class BaseNetworkServices: NetworkServices {
    var restClient: RestClient { URLSession.shared }
}
