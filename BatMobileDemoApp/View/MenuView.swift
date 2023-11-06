//
//  MenuView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/6.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        VStack(spacing: 40) {
            Button("使用說明") {}
            Button("收費方式") {}
            Button("站點資訊") {}
                .foregroundStyle(.selectedText)
            Button("最新消息") {}
            Button("活動專區") {}
            
            Spacer()
            
            Button("登入") {}
                .padding()
                .padding(.horizontal)
                .background(.white)
                .clipShape(Capsule())
                .foregroundStyle(.ubikeGreen)
                .padding(.bottom)
        }
        .padding([.top, .leading], 55)
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.ubikeGreen)
    }
}

#Preview {
    MenuView()
}
