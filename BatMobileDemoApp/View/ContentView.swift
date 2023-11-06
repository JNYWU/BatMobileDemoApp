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
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 20) {
                Divider()
                Text("站點資訊")
                    .font(.title)
                    .padding(.horizontal)
                
                TextField("搜尋站點", text: $searchText)
                    .padding(10)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                
                ScrollView {
                    
                    LazyVStack(alignment: .center, pinnedViews: [.sectionHeaders]) {
                        Section(header: HeaderView()) {
                            
                            ForEach(stations) { station in
                                StationRowView(station: station)
                            }
                            
                        }

                    }
                    .task {
                        await fetchData()
                    }
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding()

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
