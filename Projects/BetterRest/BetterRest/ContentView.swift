//
//  ContentView.swift
//  BetterRest
//
//  Created by Adam Tokarski on 03/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 4.0
    @State private var restAmount = 2.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Text(Date.now, format: .dateTime.hour().minute())
                .padding()
            
            Text(Date.now.formatted(date: .long, time: .standard))
                .padding()
            
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.1)
                .padding()
            
            Slider(value: $restAmount, in: 2...8)
                .padding()
            
            DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .date)
                .padding()
            
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
                .labelsHidden()
                .padding()
        }
        .padding()
    }
    
    private func exampleDate() {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date.now
        
        let tomorrow = Date.now.addingTimeInterval(86400)
        _ = Date.now...tomorrow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
