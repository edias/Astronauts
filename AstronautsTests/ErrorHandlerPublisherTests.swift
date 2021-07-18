//
//  ErrorHandlerPublisherTests.swift
//  AstronautsTests
//
//  Created by Eduardo Dias on 19/07/21.
//

import Combine
import XCTest
@testable import Astronauts

class ErrorHandlerPublisherTests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let errorHandlerPublisher = ErrorHandlerPublisher()
    
    func test_ErrorHandlerMapRateLimitToErrorViewType() {
        
        let expectation = XCTestExpectation(description: "Network status error rate is mapped to view error")
        
        let errorHandlerPublisher = ErrorHandlerPublisher()
        
        errorHandlerPublisher.$errorType.sink { errorType in
            guard errorType == .tooManyRequests else { return }
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        let error = Subscribers.Completion.failure(StatusCodeError.tooManyRequests as Error)
        errorHandlerPublisher.handleError(error)
    }
    
    func test_ErrorHandlerMapNetworkErrorsToGenericViewErrors() {
        
        let expectation = XCTestExpectation(description: "Network errors are mapped to generic view errors")
        
        let errorHandlerPublisher = ErrorHandlerPublisher()
        
        errorHandlerPublisher.$errorType.sink { errorType in
            guard errorType == .generic else { return }
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        let error = Subscribers.Completion.failure(StatusCodeError.forbidden as Error)
        errorHandlerPublisher.handleError(error)
    }

}
