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
    private var currencyCode = Locale.current.currency?.identifier ?? "PLN"
    
    private var amountPerPerson: Double {
        (checkAmount * (1.0 + (Double(tipPercentage) / 100.0)) / Double(numberOfPeople))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
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
                    Text(amountPerPerson, format: .currency(code: currencyCode))
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
