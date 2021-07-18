//
//  AstronautGridView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautDetailsGridView: View {
    
    var gridValues: (dateOfBirth: String, status: String, flights: String)
    
    var body: some View {
        HStack {
            AstronautDetailsGridCellView(value: gridValues.dateOfBirth, label: "Date of birth")
            AstronautDetailsGridCellDivider()
            AstronautDetailsGridCellView(value: gridValues.status, label: "Status")
            AstronautDetailsGridCellDivider()
            AstronautDetailsGridCellView(value: gridValues.flights, label: "Flights")
        }.border(ColorPalette.secondaryColor)
    }
}

struct AstronautInfoGridView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetailsGridView(gridValues: (dateOfBirth: "10-10-2010", status: "Retired", flights: "5"))
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
