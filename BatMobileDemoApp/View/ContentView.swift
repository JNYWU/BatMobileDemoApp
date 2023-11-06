//
//  ContentView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/5.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stations = [Station]()
    @State private var searchText = ""
    @State private var showSuggestion = false
    @State private var showMenu = false
    @FocusState private var searchisFocused: Bool
    
    var searchedStations: [Station] {
        if searchText.isEmpty {
            return stations
        } else {
            // filter station with searchText
            return stations.filter { $0.area.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            // ZStack for MenuView
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Title
                    Text("站點資訊")
                        .foregroundStyle(.ubikeGreen)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(.horizontal)
                    
                    // SearchField
                    SearchFieldView(searchText: $searchText, searchisFocused: $searchisFocused, showSuggestion: $showSuggestion)
                    
                    // ZStack for search suggestion
                    ZStack(alignment: .top) {
                        
                        // Tie sticky header and scroll view together to clipshape
                        VStack(spacing: 0) {
                            
                            // Sticky header of scroll view
                            HeaderView()
                            
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(0 ..< searchedStations.count, id: \.self) { index in
                                        StationRowView(station: searchedStations[index])
                                            // toggle background color between white and gray
                                            .background(index % 2 == 0 ? .white : Color(UIColor.secondarySystemBackground))
                                    }
                                }
                            }
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        // Gray outline of scroll view
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .padding()
                        
                        // Show search suggestions
                        if searchisFocused {
                            SuggestionView(searchText: $searchText, showSuggestion: $showSuggestion, searchisFocused: $searchisFocused, stations: $stations)
                        }
                        
                    }
                    
                }
                .padding(.top)
                
                // Show MenuView
                if showMenu {
                    MenuView()
                }
                
            }
            // Top Navigation Bar
            .safeAreaInset(edge: .top, spacing: 0) {
                NavigationBarView(showMenu: $showMenu)
                    .onTapGesture {
                        searchisFocused = false
                    }
            }
            
        }
        .task {
            await fetchData()
        }
        
    }
    
    // Get data and decode json
    func fetchData() async {
        // create URL
        guard let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json") else {
            return
        }
        
        // fetch data
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([Station].self, from: data) {
                stations = decodedResponse
            }
        } catch {
            
        }
    }
    
}



#Preview {
    ContentView()
}

