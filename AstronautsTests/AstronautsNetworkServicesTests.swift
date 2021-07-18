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

    private var mockAstronautsNetworkServices: MockAstronautsNetworkServices!
    
    override func setUp() {
        mockAstronautsNetworkServices = MockAstronautsNetworkServices()
    }
    
    func test_astronautsReturnsSuccessfully() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": [{ "id": 1, "name": "John", "nationality": "Canadian","profileImageThumbnail": ""}]
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts returns successfully")
        
        mockAstronautsNetworkServices.fetchAstronauts().sink { _ in } receiveValue: { astronauts in
            XCTAssertEqual(astronauts.count, 1)
            XCTAssertEqual(astronauts.first?.nationality, "Canadian")
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_astronautsReturnsWithEmptyList() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": []
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts returns with empty list")
        
        mockAstronautsNetworkServices.fetchAstronauts().sink { _ in } receiveValue: { astronauts in
            XCTAssertTrue(astronauts.isEmpty)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithMalformedData() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": [{ "id": 1, "name": "John", "nationality: "Canadian","profileImageThumbnail": ""}]
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to serialization issue with malformed data")
        
        mockAstronautsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error) where error is DecodingError:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithEmptyData() {
        
        mockAstronautsNetworkServices.jsonString = ""
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to serialization issue with empty data")
        
        mockAstronautsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error) where error is DecodingError:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithErrorStatusCode() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": []
        }
        """
        
        mockAstronautsNetworkServices.statusCode = 500
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to error status code")
        
        mockAstronautsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error as StatusCodeError) where error == StatusCodeError.internalServerError:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsReturnsFailWithRateLimitError() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": []
        }
        """
        
        mockAstronautsNetworkServices.statusCode = 429
        
        let expectation = XCTestExpectation(description: "Astronauts don't return due to reached limit requests")
        
        mockAstronautsNetworkServices.fetchAstronauts().sink { error in
            switch error {
                case .failure(let error as StatusCodeError) where error == StatusCodeError.tooManyRequests:
                    expectation.fulfill()
                default: break
            }
            
        } receiveValue: { _ in }.store(in: &susbcriptions)
        
        wait(for: [expectation], timeout: 1)
    }
}
