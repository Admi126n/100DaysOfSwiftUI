//
//  ContentView.swift
//  WeSplit
//
//  Created by Adam Tokarski on 24/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private let peopleRange = 2...10
    private let tipPercentages = [0, 5, 10, 15, 20, 25]
    private var currencyFormat: FloatingPointFormatStyle<Double>.Currency =
        .currency(code: Locale.current.currency?.identifier ?? "PLN")
    
    private var totalAmount: Double {
        checkAmount * (1.0 + (Double(tipPercentage) / 100.0))
    }
    
    private var amountPerPerson: Double {
        totalAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Stepper("Number of people: \(numberOfPeople)",value: $numberOfPeople,
                            in: peopleRange)
                }
                
                Section {
                    Picker("Tip percantage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip percentage")
                        .textCase(nil)
                }
                
                Section {
                    Text(totalAmount, format: currencyFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount")
                        .textCase(nil)
                }
                
                Section {
                    Text(amountPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount per person")
                        .textCase(nil)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
