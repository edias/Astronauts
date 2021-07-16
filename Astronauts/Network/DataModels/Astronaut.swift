//
//  Astronaut.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation

struct Astronaut: Codable {
    let name: String
    let nationality: String
    let profileImageThumbnail: URL
}

struct AstronautsResult: Codable {
    let results: [Astronaut]
}
