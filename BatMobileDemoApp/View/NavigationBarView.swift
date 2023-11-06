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
            Image(.youBike)
                .resizable()
                .scaledToFill()
                .frame(width: 35, height: 35)
                .padding(.leading, 40)
            
            Spacer()
            
            Button {
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title)
                    .foregroundStyle(.ubikeGreen)
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
