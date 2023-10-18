//
//  User.swift
//  Friends
//
//  Created by Adam Tokarski on 18/10/2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
