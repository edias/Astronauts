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
    
    func test_errorIsSetToNilAfterRetrySuccessfully() {
        
        mockAstronautsNetworkServices.jsonString = ""
        
        let expectation = XCTestExpectation(description: "Error type is set to nil after details are loaded sucessfuly")
        
        let vm = AstronautDetailsViewModel(mockAstronautsNetworkServices)
        
        let stopTrigger = PassthroughSubject<Void, Never>()
        
        vm.$errorType.dropFirst().prefix(untilOutputFrom: stopTrigger).sink { errorType in
            
            XCTAssertNotNil(errorType)
            XCTAssertEqual(errorType, ErrorType.generic)
            
            self.mockAstronautsNetworkServices.jsonString = """
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
            
            //  After receiving an error event the error screen is displaying.
            // Now we stop receiving events from this subscription.
            stopTrigger.send()
            
            // We call this operation once this is what the try again button does
            vm.loadAstronautDetails(1)

        }.store(in: &susbcriptions)
        
        vm.$errorType.dropFirst(2).sink { errorType in
            XCTAssertNil(errorType)
            expectation.fulfill()
        }.store(in: &susbcriptions)
        
        vm.loadAstronautDetails(1)
        
        wait(for: [expectation], timeout: 1)
    }
}
