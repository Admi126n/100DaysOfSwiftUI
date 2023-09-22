//
//  AddView.swift
//  iExpense
//
//  Created by Adam Tokarski on 21/09/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var amount = 0.0
    @State private var type = ExpenseType.personal
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.sentences)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                
                TextField("Amount", value: $amount, format: Expenses.currencyFormat)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    guard !name.isEmpty else {
                        alertTitle = "Name cannot be empty!"
                        showAlert = true
                        return
                    }
                    
                    guard amount != 0.0 else {
                        alertTitle = "Amount cannot equal 0!"
                        showAlert = true
                        return
                    }
                    
                    let item = ExpenseItem(name: name, type: type.rawValue, amount: amount)
                    expenses.addExpense(item)
                    dismiss()
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") { }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
