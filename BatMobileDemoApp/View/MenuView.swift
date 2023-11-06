//
//  MenuView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/6.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 40) {
            Text("使用說明")
            Text("收費方式")
            Text("站點資訊")
                .foregroundStyle(.selectedText)
            Text("最新消息")
            Text("活動專區")
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ubikeGreen)
    }
}

#Preview {
    MenuView()
}
