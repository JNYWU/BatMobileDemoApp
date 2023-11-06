//
//  HeaderView.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/5.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("縣市")
                .padding(.leading, 10)
                .padding(.trailing, 48)
            Text("區域")
                .padding(.trailing, 68)
            Text("站點名稱")
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.green)
//        .padding(.horizontal)
    }
}

#Preview {
    HeaderView()
}
