//
//  Coalition.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 21.8.2023.
//

import Foundation

struct Coalition: Codable {
        let id: Int
        let name: String
        let image_url: String
        let color: String
}

struct CoalitionType: Codable {
    var id: Int
    var color: String
    var background: String
    var logo: String
    
    init(id: Int, color: String, background: String, logo: String) {
        self.id = id;
        self.color = color
        self.background = background
        self.logo = logo
    }
}

extension CoalitionType {
    static let HiveCoalitions: [CoalitionType] = [
        CoalitionType(id: 273, color: "#C574AB", background: "GuardsBackground", logo: "guards"),
        CoalitionType(id: 272, color: "#7FBE80", background: "ForagersBackground", logo: "foragers"),
        CoalitionType(id: 271, color: "#EE7800", background: "BuildersBackground", logo: "builders"),
        CoalitionType(id: 0, color: "MainBlue", background: "Background", logo: "Logo")
    ]
}
