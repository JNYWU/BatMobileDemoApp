//
//  ContentView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/5.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stations = [Station]()
    
    var body: some View {
        NavigationStack {
            List(stations) { station in
                VStack(alignment: .leading) {
                    Text(station.area)
                    Text(station.name)
                    
                }
            }
            .task {
                await fetchData()
            }
            .safeAreaInset(edge: .top) {
                NavigationBarView()
            }
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

#Preview {
    ContentView()
}
