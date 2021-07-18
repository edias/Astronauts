//
//  Astronaut.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation

struct Astronaut: Codable, Hashable {
    let id: Int
    let name: String
    let nationality: String
    let profileImageThumbnail: String
}

struct AstronautsResult: Codable {
    let results: [Astronaut]
}
