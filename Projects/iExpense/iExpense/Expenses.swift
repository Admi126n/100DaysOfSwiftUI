//
//  Expenses.swift
//  iExpense
//
//  Created by Adam Tokarski on 21/09/2023.
//

import Foundation

class Expenses: ObservableObject {
    @Published private(set) var personalItems: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey: ExpenseType.personal.rawValue)
            }
        }
    }
    
    @Published private(set) var buisnessItems: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(buisnessItems) {
                UserDefaults.standard.set(encoded, forKey: ExpenseType.buisness.rawValue)
            }
        }
    }
    
    static var currencyFormat: FloatingPointFormatStyle<Double>.Currency =
        .currency(code: Locale.current.currency?.identifier ?? "PLN")
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: ExpenseType.personal.rawValue) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                personalItems = decodedItems
            }
        }
        
        if let savedItems = UserDefaults.standard.data(forKey: ExpenseType.buisness.rawValue) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                buisnessItems = decodedItems
            }
        }
        
        if personalItems.isEmpty { personalItems = [] }
        if buisnessItems.isEmpty { buisnessItems = [] }
    }
    
    func addExpense(_ expense: ExpenseItem) {
        if expense.type == ExpenseType.personal.rawValue {
            personalItems.append(expense)
        } else {
            buisnessItems.append(expense)
        }
    }
    
    func removePersonalExpense(at offsets: IndexSet) {
        personalItems.remove(atOffsets: offsets)
    }
    
    func removeBuisnessExpense(at offsets: IndexSet) {
        buisnessItems.remove(atOffsets: offsets)
    }
}
