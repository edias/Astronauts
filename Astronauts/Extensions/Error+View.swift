//
//  Error+View.swift
//  Astronauts
//
//  Created by Eduardo Dias on 18/07/21.
//

import SwiftUI

extension View {
    @ViewBuilder
    func onError(_ errorType: ErrorType? = nil, retryAction: @escaping () -> Void) -> some View {
        ZStack {
            if let errorType = errorType {
                ErrorView(errorType, retryAction: retryAction)
            } else {
                self
            }
        }
    }
}
