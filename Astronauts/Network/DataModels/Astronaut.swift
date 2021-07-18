//
//  Astronaut.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation

struct Astronaut: Codable {
    let id: Int
    let name: String
    let nationality: String
    let profileImageThumbnail: String
}

struct AstronautsResult: Codable {
    let results: [Astronaut]
}


extension Astronaut: Hashable, Comparable {
    static func < (lhs: Astronaut, rhs: Astronaut) -> Bool {
        lhs.name < rhs.name
    }
}
