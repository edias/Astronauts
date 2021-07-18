//
//  AstronaultDetailsViewmodel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import Foundation

struct AstronautDetailsDataModel {
    let id: Int
    let name: String
    let nationality: String
    let bio: String
    let imageUrl: String
    let gridValues: (dateOfBirth: String, status: String, flights: String)
}
