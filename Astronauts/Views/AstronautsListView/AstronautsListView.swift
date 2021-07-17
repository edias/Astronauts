//
//  ContentView.swift
//  Astronauts
//
//  Created by Eduardo Dias on 17/07/21.
//

import SwiftUI

struct AstronautsListView: View {
    
    @ObservedObject
    private var viewModel = AstronautsListViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ScrollView {
                    ForEach(viewModel.astronauts, id: \.self) { astronaut in
                        AstronautRollView(astronaut)
                    }
                    .listStyle(GroupedListStyle())
                }
            }.navigationTitle("Astronauts")
        }
        .onAppear { viewModel.loadAstronaults() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautsListView()
    }
}
