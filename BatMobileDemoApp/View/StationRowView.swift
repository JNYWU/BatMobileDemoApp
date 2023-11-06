//
//  StationRowView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/5.
//

import SwiftUI

struct StationRowView: View {
    var station: Station
    
    var body: some View {
        HStack(spacing: 42) {
            Text("台北市")
            
            Text(station.area)
            
            Text(station.name.replacingOccurrences(of: "YouBike2.0_", with: ""))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    StationRowView(station: Station(area: "大安區", name: "YouBike2.0_捷運科技大樓站"))
}
