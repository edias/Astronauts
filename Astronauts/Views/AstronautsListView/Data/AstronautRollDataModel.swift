//
//  AstronautRollDataModel.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import Foundation
import SwiftUI

struct AstronautRollDataModel {
    let id: Int
    let name: String
    let nationality: String
    let imageUrl: String
    let colors: [Color]
}

extension AstronautRollDataModel: Hashable, Comparable {
    static func < (lhs: AstronautRollDataModel, rhs: AstronautRollDataModel) -> Bool {
        lhs.name < rhs.name
    }
}
