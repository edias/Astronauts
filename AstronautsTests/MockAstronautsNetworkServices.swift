//
//  MockAstronautsNetworkServices.swift
//  AstronautsTests
//
//  Created by Eduardo Dias on 19/07/21.
//

import Combine
import Foundation
@testable import Astronauts

class MockAstronautsNetworkServices: AstronautsNetworkServices {
    var jsonString: String = ""
    var statusCode: Int = 200
    override var restClient: RestClient { MockRestClient(jsonString: jsonString, statusCode: statusCode) }
}
