//
//  AstronautDetailsViewModelTests.swift
//  AstronautsTests
//
//  Created by Eduardo Dias on 19/07/21.
//

import Combine
import XCTest
@testable import Astronauts

class AstronautDetailsViewModelTests: XCTestCase {
    
    private var susbcriptions = Set<AnyCancellable>()
    
    private let mockAstronautsNetworkServices = MockAstronautsNetworkServices()
    
    override func setUp() {
        susbcriptions = Set<AnyCancellable>()
    }
    
    struct AstronautDetails: Codable {
        let id: Int
        let name: String
        let status: Status
        let nationality: String
        let dateOfBirth: String
        let bio: String
        let profileImageThumbnail: String
        let flights: [Flight]
    }
        
    func test_astronautDetailsIsLoadedSuccesfully() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "id": 1,
        "name": "John",
        "status": {"id": 1, "name": "Retired"},
        "nationality": "American",
        "date_of_birth": "10-02-1956",
        "bio": "",
        "profile_image_thumbnail": "",
        "flights": []
        }
        """
        
        let expectation = XCTestExpectation(description: "Astronaut details is populated after loaded succesfully")
        
        let vm = AstronautDetailsViewModel(mockAstronautsNetworkServices)
        
        vm.$astronaut.dropFirst().sink { astronautDetails in
            XCTAssertEqual(astronautDetails.gridValues.dateOfBirth, "10-02-1956")
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronautDetails(0)
        
        wait(for: [expectation], timeout: 1)
    }

    func test_isAstronautsDetailsLoadedFlagChangeToTrueAfterDetailsIsLoaded() {
        
        mockAstronautsNetworkServices.jsonString = """
        {
        "id": 1,
        "name": "John",
        "status": {"id": 1, "name": "Retired"},
        "nationality": "American",
        "date_of_birth": "10-02-1956",
        "bio": "",
        "profile_image_thumbnail": "",
        "flights": []
        }
        """
        
        let expectation = XCTestExpectation(description: "isAstronautsDetailsLoaded flag change to true")
        
        let vm = AstronautDetailsViewModel(mockAstronautsNetworkServices)
        
        vm.$isAstronautsDetailsLoaded.dropFirst(1).sink { isLoaded in
            XCTAssertTrue(isLoaded)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronautDetails(1)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_errorTypeIsSetWhenAstronautDetailsFailsToLoad() {
        
        mockAstronautsNetworkServices.jsonString = ""
        
        let expectation = XCTestExpectation(description: "Error type is set when astronaut fails to load due to an error")
        
        let vm = AstronautDetailsViewModel(mockAstronautsNetworkServices)
        
        vm.$errorType.dropFirst().sink { errorType in
            XCTAssertNotNil(errorType)
            XCTAssertEqual(errorType, ErrorType.generic)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronautDetails(1)
        
        wait(for: [expectation], timeout: 1)
    }
}
