//
//  ActivityItem.swift
//  iActivity
//
//  Created by Adam Tokarski on 05/10/2023.
//

import Foundation

struct ActivityItem: Codable, Identifiable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var count = 0
}
