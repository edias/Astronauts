//
//  AstronautsNetworkServicesTests.swift
//  AstronautsTests
//
//  Created by Eduardo Dias on 19/07/21.
//


import Combine
import XCTest
@testable import Astronauts

class AstronautsNetworkServicesTests: XCTestCase {
    
    private var susbcriptions = Set<AnyCancellable>()

    private var mockAstronaultsNetworkServices: MockAstronautsNetworkServices!
    
    override func setUp() {
        mockAstronaultsNetworkServices = MockAstronautsNetworkServices()
    }
    
    func test_astronautsReturnsSuccessfully() {
        
        mockAstronaultsNetworkServices.jsonString = """
        {
        "results": [{ "id": 1, "name": "John", "nationality": "Canadian","profileImageThumbnail": ""}]
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts returns successfully")
        
        mockAstronaultsNetworkServices.fetchAstronauts().sink { _ in } receiveValue: { astronauts in
            XCTAssertEqual(astronauts.count, 1)
            XCTAssertEqual(astronauts.first?.nationality, "Canadian")
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_astronautsReturnsWithEmptyList() {
        
        mockAstronaultsNetworkServices.jsonString = """
        {
        "results": []
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts returns with empty list")
        
        mockAstronaultsNetworkServices.fetchAstronauts().sink { _ in } receiveValue: { astronauts in
            XCTAssertTrue(astronauts.isEmpty)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithMalformedData() {
        
        mockAstronaultsNetworkServices.jsonString = """
        {
        "results": [{ "id": 1, "name": "John", "nationality: "Canadian","profileImageThumbnail": ""}]
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to serialization issue with malformed data")
        
        mockAstronaultsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error) where error is DecodingError:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithEmptyData() {
        
        mockAstronaultsNetworkServices.jsonString = ""
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to serialization issue with empty data")
        
        mockAstronaultsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error) where error is DecodingError:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithErrorStatusCode() {
        
        mockAstronaultsNetworkServices.jsonString = """
        {
        "results": []
        }
        """
        
        mockAstronaultsNetworkServices.statusCode = 500
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to error status code")
        
        mockAstronaultsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error as StatusCodeError) where error == StatusCodeError.internalServerError:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithRateLimitError() {
        
        mockAstronaultsNetworkServices.jsonString = """
        {
        "results": []
        }
        """
        
        mockAstronaultsNetworkServices.statusCode = 429
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to reached limit requests")
        
        mockAstronaultsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error as StatusCodeError) where error == StatusCodeError.tooManyRequests:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
}
