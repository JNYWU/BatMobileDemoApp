//
//  NavigationBarView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/5.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        HStack {
            Text("Ubike")
                .font(.largeTitle)
                .foregroundStyle(.black)
            
            Spacer()
            
            Button("test") {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
        .padding()
        .background(.white)
    }
}

#Preview {
    NavigationBarView()
}
