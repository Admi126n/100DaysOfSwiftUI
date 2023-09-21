//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Adam Tokarski on 21/09/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
