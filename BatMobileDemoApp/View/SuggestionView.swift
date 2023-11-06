//
//  SuggestionView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/6.
//

import SwiftUI

struct SuggestionView: View {
    
    @Binding var searchText: String
    @Binding var showSuggestion: Bool
    @FocusState.Binding var searchisFocused: Bool
    @Binding var stations: [Station]
    
    var body: some View {
        ScrollView {
            
            // Get areas contain searchText
            let areaArray = getAreaArray(stations: stations).filter { $0.contains(searchText) }
            
            // Show the areas as Button
            ForEach(areaArray, id: \.self) { area in
                Button {
                    // assign value to searchText on tap
                    searchText = area
                    showSuggestion = false
                    searchisFocused = false
                    
                } label: {
                    Text(area)
                    Spacer()
                }
                .foregroundStyle(.black)
                .padding(10)
                
            }
            
            .frame(maxWidth: .infinity)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
        }
        .onTapGesture {
            searchisFocused = false
        }
        .scrollDisabled(true)
    }
}

// Function to get all the areas without duplicates
func getAreaArray(stations: [Station]) -> [String] {
    
    var area: [String] = []
    
    for index in 0 ..< stations.count {
        area.append(stations[index].area)
    }
    
    area = Array(Set(area))
    
    return area
}
