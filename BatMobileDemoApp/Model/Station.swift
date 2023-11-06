//
//  Station.swift
//  BatMobileDemoApp
//
//  Created by 吳求元 on 2023/11/5.
//

import Foundation

struct Station: Decodable, Hashable, Identifiable {
    var id = UUID()
    var area: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case area = "sarea"
        case name = "sna"
    }
}
