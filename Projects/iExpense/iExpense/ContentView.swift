//
//  ContentView.swift
//  iExpense
//
//  Created by Adam Tokarski on 20/09/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section(ExpenseType.personal.rawValue) {
                    ForEach(expenses.personalItems) {
                        ExpenseCell(item: $0)
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section(ExpenseType.buisness.rawValue) {
                    ForEach(expenses.buisnessItems) {
                        ExpenseCell(item: $0)
                    }
                    .onDelete(perform: removeBuisnessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    private func removePersonalItems(at offsets: IndexSet) {
        expenses.removePersonalExpense(at: offsets)
    }
    
    private func removeBuisnessItems(at offsets: IndexSet) {
        expenses.removeBuisnessExpense(at: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Custom Views

fileprivate struct ExpenseCell: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(item.name)
                    .bold()
                
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: Expenses.currencyFormat)
                .amountStyle(for: item.amount)
        }
    }
}

// MARK: - Custom View Modifiers

fileprivate struct ExpenseCellColor: ViewModifier {
    private let amount: Double
    
    init(for amount: Double) {
        self.amount = amount
    }
    
    private var color: Color {
        switch amount {
        case ...10:
            return .green
        case ...100:
            return .yellow
        default:
            return .red
        }
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
    }
}

// MARK: - Custom View extensions

extension View {
    func amountStyle(for amount: Double) -> some View {
        modifier(ExpenseCellColor(for: amount))
    }
}
