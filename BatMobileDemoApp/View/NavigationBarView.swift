//
//  NavigationBarView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/5.
//

import SwiftUI

struct NavigationBarView: View {
        
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack {
            HStack {
                // Ubike Logo
                Image(.youBike)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 33, height: 33)
                    .padding(.leading, 40)
                
                Spacer()
                
                // Sandwich Button
                Button {
                    showMenu.toggle()
                    
                } label: {
                    // Show X if menu is showing
                    Image(systemName: showMenu ? "xmark" : "line.3.horizontal")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.ubikeGreen)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            .padding()
            .background(.white)
            
            if !showMenu {
                Divider()
            }
        }
        
    }
}

#Preview {
    NavigationBarView(showMenu: .constant(false))
}
