//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Adam Tokarski on 27/08/2023.
//

import SwiftUI

fileprivate enum TempUnits: String {
    case kelvin = "Kelvin"
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
}

struct ContentView: View {
    @State private var inputUnit: TempUnits = .celsius
    @State private var outputUnit: TempUnits = .kelvin
    @State private var inputTemp = 0.0
    @FocusState private var inputIsFocused: Bool
    
    private let tempUnits: [TempUnits] = [.kelvin, .celsius, .fahrenheit]
    
    private var outputUnits: [TempUnits] {
        tempUnits.filter { $0 != inputUnit }
    }
    
    private var unitSymbol: String {
        let symbol = String(outputUnit.rawValue.prefix(1))
        return "\(symbol != "K" ? "°" : "")\(symbol)"
    }
    
    private var outputTemp: String {
        String(format: "%.2f \(unitSymbol)", calculateTemp(inputUnit, outputUnit, inputTemp))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(outputUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section {
                    TextField("Input temperature", value: $inputTemp, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Input temperature")
                        .textCase(nil)
                }
                
                Section {
                    Text("\(outputTemp)")
                } header: {
                    Text("Output temperature")
                        .textCase(nil)
                }
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

fileprivate func calculateTemp(_ inputUnit: TempUnits, _ outputUnit: TempUnits,
                               _ inputValue: Double) -> Double {
    switch (inputUnit, outputUnit) {
    case (.celsius, .fahrenheit):
        return (inputValue * 9.0 / 5.0) + 32.0
    case (.celsius, .kelvin):
        return inputValue + 273.15
    case (.fahrenheit, .celsius):
        return (inputValue - 32) * 5 / 9
    case (.fahrenheit, .kelvin):
        return (inputValue - 32) * 5 / 9 + 273.15
    case (.kelvin, .celsius):
        return inputValue - 273.15
    case (.kelvin, .fahrenheit):
        return ((inputValue - 273.15) * 9.0 / 5.0) + 32.0
    default:
        return 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
