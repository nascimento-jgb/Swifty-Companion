//
//  CampusList.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 20.8.2023.
//

import Foundation

struct CampusUsers: Codable, Identifiable {
    var id: Int
    var login: String
    var image: Image42
}

struct Image42: Codable {
    var link: String?
}
