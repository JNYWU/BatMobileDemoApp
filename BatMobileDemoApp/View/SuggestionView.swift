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
            
            let areaArray = getAreaArray(stations: stations).filter { $0.contains(searchText) }
            
            ForEach(areaArray, id: \.self) { area in
                Button {
                    searchText = area
                    showSuggestion = false
                    searchisFocused = false
                    
                } label: {
                    Text(area)
                    Spacer()
                }
                .foregroundStyle(.black)
                .padding()
                
            }
            
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
        }
        .onTapGesture {
            searchisFocused = false
        }
        .scrollDisabled(true)
    }
}
