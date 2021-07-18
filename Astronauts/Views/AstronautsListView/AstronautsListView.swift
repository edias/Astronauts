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
                
                HStack {
                    Spacer()
                    SortingButton(isSortingAscendent: $viewModel.isSortingAscendent)
                }.padding(.trailing, 12)
                
                ScrollView {
                    ForEach(viewModel.astronauts, id: \.self) { astronaut in
                        NavigationLink(destination: AstronautDetailsView(astronautId: astronaut.id)) {
                            AstronautRollView(astronaut).background(Color.white)
                        }.buttonStyle(PlainButtonStyle())
                    }.listStyle(GroupedListStyle())
                }
            }.navigationTitle("Astronauts")
        }
        .onAppear { viewModel.loadAstronauts() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautsListView()
    }
}
