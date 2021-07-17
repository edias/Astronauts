//
//  Environments.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import Foundation

struct Environment {
    enum URLS: String {
        case base = "https://spacelaunchnow.me"
    }
}

extension Environment.URLS: CustomStringConvertible {
    var description: String { rawValue }
}
