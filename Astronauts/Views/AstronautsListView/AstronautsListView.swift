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
                        NavigationLink(destination: AstronautDetailsView(astronautId: astronaut.id, colors: astronaut.colors)) {
                            AstronautRollView(astronaut).background(ColorPalette.primaryColor)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .listStyle(GroupedListStyle())
                    .unredacted(when: viewModel.isAstronautsLoaded)
                }
            }.navigationTitle("Astronauts")
        }
        .accentColor(ColorPalette.lightColor)
        .onAppear { viewModel.loadAstronauts() }
        .onError(viewModel.errorType, retryAction: { viewModel.loadAstronauts() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautsListView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}
