//
//  MockBuilder.swift
//  Astronauts
//
//  Created by Eduardo Dias on 19/07/21.
//

import Foundation

class MockBuilder {
    
    static func makeAstronauts() -> [AstronautRollDataModel] {
        (0...11).map { _ -> AstronautRollDataModel in
            AstronautRollDataModel(id: 0,
                                   name: "Astronaut Name",
                                   nationality: "Nationality",
                                   imageUrl: "",
                                   colors: [])
        }
    }
}
