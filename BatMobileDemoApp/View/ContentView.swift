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
            return stations.filter { $0.area.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("站點資訊")
                        .foregroundStyle(.ubikeGreen)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(.horizontal)
                    
                    SearchFieldView(searchText: $searchText, searchisFocused: $searchisFocused, showSuggestion: $showSuggestion)
                    
                    ZStack(alignment: .top) {
                        VStack(spacing: 0) {
                            HeaderView()
                            
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(0 ..< searchedStations.count, id: \.self) { index in
                                        StationRowView(station: searchedStations[index])
                                            .background(index % 2 == 0 ? .white : Color(UIColor.secondarySystemBackground))
                                    }
                                }
                            }
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .padding()
                        
                        if searchisFocused {
                            SuggestionView(searchText: $searchText, showSuggestion: $showSuggestion, searchisFocused: $searchisFocused, stations: $stations)
                        }
                        
                    }
                    
                }
                .padding(.top)
                
                if showMenu {
                    MenuView()
                }
                
            }
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

func getAreaArray(stations: [Station]) -> [String] {
    
    var area: [String] = []
    
    for index in 0 ..< stations.count {
        area.append(stations[index].area)
    }
    
    area = Array(Set(area))
    
    return area
}

#Preview {
    ContentView()
}

