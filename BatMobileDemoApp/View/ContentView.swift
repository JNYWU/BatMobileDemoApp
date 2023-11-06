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
            
            VStack(alignment: .leading, spacing: 20) {
                Divider()
                Text("站點資訊")
                    .foregroundStyle(.ubikeGreen)
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.horizontal)
                
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
            .safeAreaInset(edge: .top) {
                NavigationBarView()
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

