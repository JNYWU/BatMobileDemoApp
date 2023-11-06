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
                .padding(.leading, 23)
            Text("區域")
                .padding(.leading, 49)
            Text("站點名稱")
                .padding(.leading, 64)

        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.green)
    }
}

#Preview {
    HeaderView()
}
