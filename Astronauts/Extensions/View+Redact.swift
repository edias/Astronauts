//
//  View+Redact.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import SwiftUI

extension View {
    @ViewBuilder
    func unredacted(when condition: Bool) -> some View {
        if condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
        }
    }
}
