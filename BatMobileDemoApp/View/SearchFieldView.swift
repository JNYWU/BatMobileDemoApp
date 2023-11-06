//
//  SearchFieldView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/6.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchText: String
    @FocusState.Binding var searchisFocused: Bool
    @Binding var showSuggestion: Bool
    
    var body: some View {
        // ZStack for magnifyingglass symbol
        ZStack(alignment: .trailing) {
            TextField("搜尋站點", text: $searchText)
                .padding(10)
                .foregroundStyle(.ubikeGreen)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .focused($searchisFocused)
                .onChange(of: searchText) {
                    showSuggestion = searchText.isEmpty ? false : true
                }
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color(UIColor.lightGray) : .ubikeGreen)
                .padding(.trailing)
        }
        .padding(.horizontal)
    }
}
