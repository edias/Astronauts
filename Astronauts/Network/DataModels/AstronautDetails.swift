//
//  AstronautDetails.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import Foundation

struct Flight: Codable{
    let id: String
    let name: String
}

struct AstronautDetails: Codable {
    let id: Int
    let name: String
    let nationality: String
    let bio: String
    let dateOfBirth: String
    let profileImageThumbnail: String
    let flights: [Flight]
}
