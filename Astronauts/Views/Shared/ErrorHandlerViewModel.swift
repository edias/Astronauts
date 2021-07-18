//
//  ErrorHandlerViewModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import Combine
import Foundation

protocol ErrorHandable {
    func handleError(_ error: Subscribers.Completion<Error>)
}

class ErrorHandlerPublisher: ObservableObject {
    
    @Published
    var errorType: ErrorType?
    
    func handleError(_ error: Subscribers.Completion<Error>) {
        switch error {
            case .failure(let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
                errorType = .offline
            case .failure(let error as StatusCodeError) where error == .tooManyRequests:
                errorType = .tooManyRequests
            case .failure:
                errorType = .generic
            default:
                errorType = nil
        }
    }
}
