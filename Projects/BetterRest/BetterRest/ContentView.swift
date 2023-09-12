//
//  ContentView.swift
//  BetterRest
//
//  Created by Adam Tokarski on 03/09/2023.
//

import CoreML
import SwiftUI

fileprivate struct SectionHeader: View {
    private let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.headline)
    }
}

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    private let coffeAmounts = 1..<21
    
    static private var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    private var bedTime: Date {
        return calculateBedTime()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Your ideal bedtime is \(bedTime.formatted(date: .omitted, time: .shortened)).")
                        .font(.title2)
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        DatePicker("Please enter a time",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    }
                } header: {
                    SectionHeader("When do you want to wake up?")
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 4...12,
                            step: 0.25)
                } header: {
                    SectionHeader("Desired amount of sleep")
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Picker("Coffee amount", selection: $coffeeAmount) {
                            ForEach(coffeAmounts, id: \.self) {
                                Text($0 == 1 ? "1 cup" : "\($0) cups")
                            }
                        }
                        .labelsHidden()
                    }
                } header: {
                    SectionHeader("Daily coffee intake")
                }
            }
            .navigationTitle("Better rest")
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showAlert = true
            return Date.now
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
