//
//  AstronautsListViewModelTests.swift
//  AstronautsTests
//
//  Created by Eduardo Dias on 19/07/21.
//

import Combine
import XCTest
@testable import Astronauts

class AstronautsListViewModelTests: XCTestCase {
    
    private var susbcriptions = Set<AnyCancellable>()
    
    private let mockAstronautsNetworkServices = MockAstronautsNetworkServices()
    
    override func setUp() {
        susbcriptions = Set<AnyCancellable>()
    }
        
    func test_astronautsArePopulatedAfterLoadedSuccesfully() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": [
        { "id": 1, "name": "John", "nationality": "Canadian","profileImageThumbnail": ""},
        { "id": 2, "name": "Paul", "nationality": "American","profileImageThumbnail": ""}]
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts are populated after loaded succesfully")
        
        let vm = AstronautsListViewModel(mockAstronautsNetworkServices)
        
        vm.$astronauts.dropFirst(3).sink { astronauts in
            XCTAssertEqual(astronauts.count, 2)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronauts()
        
        wait(for: [expectation], timeout: 1)
    }

    func test_astronautsLoadedFlagChangeToTrueAfterAstronautsAreLoaded() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": [{ "id": 1, "name": "John", "nationality": "Canadian","profileImageThumbnail": ""}]
        }
        """
        let expectation = XCTestExpectation(description: "Astronauts isLoaded flag change to true")
        
        let vm = AstronautsListViewModel(mockAstronautsNetworkServices)
        
        vm.$isAstronautsLoaded.dropFirst(2).sink { isLoaded in
            XCTAssertTrue(isLoaded)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronauts()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_errorTypeIsSetWhenAstronautsFailsToLoad() {
        
        mockAstronautsNetworkServices.jsonString = ""
        
        let expectation = XCTestExpectation(description: "Error type is set when astronauts fails to load")
        
        let vm = AstronautsListViewModel(mockAstronautsNetworkServices)
        
        vm.$errorType.dropFirst().sink { errorType in
            XCTAssertNotNil(errorType)
            XCTAssertEqual(errorType, ErrorType.generic)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronauts()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsAreFilteredAscendently() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": [
        { "id": 1, "name": "John", "nationality": "Canadian", "profileImageThumbnail": ""},
        { "id": 2, "name": "Paul", "nationality": "American", "profileImageThumbnail": ""},
        { "id": 3, "name": "Ana", "nationality": "American", "profileImageThumbnail": ""}]
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts are sorted by $isSortingAscendent property")
        
        let vm = AstronautsListViewModel(mockAstronautsNetworkServices)
        
        vm.$astronauts.dropFirst(4).sink { astronauts in
            XCTAssertEqual(astronauts.count, 3)
            XCTAssertEqual(astronauts.first?.name, "Ana")
            XCTAssertEqual(astronauts.last?.name, "Paul")
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronauts()
        vm.isSortingAscendent = true
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_astronautsAreFilteredDescendently() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "results": [
        { "id": 1, "name": "John", "nationality": "Canadian", "profileImageThumbnail": ""},
        { "id": 2, "name": "Paul", "nationality": "American", "profileImageThumbnail": ""},
        { "id": 3, "name": "Ana", "nationality": "American", "profileImageThumbnail": ""}]
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronauts are sorted by $isSortingAscendent property")
        
        let vm = AstronautsListViewModel(mockAstronautsNetworkServices)
        
        vm.$astronauts.dropFirst(4).sink { astronauts in
            XCTAssertEqual(astronauts.count, 3)
            XCTAssertEqual(astronauts.first?.name, "Paul")
            XCTAssertEqual(astronauts.last?.name, "Ana")
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronauts()
        vm.isSortingAscendent = false
        
        wait(for: [expectation], timeout: 1)
    }
}
