//
//  ContentView.swift
//  WeSplit
//
//  Created by Adam Tokarski on 24/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    @State private var selectedName = "Adam"
    private let names = ["Adam", "Ida", "Paul"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(names, id: \.self) {
                        Text("Hello \($0)!")
                    }
                } header: {
                    Text("Hello section")
                        .textCase(nil)
                }
                
                Section {
                    Button("Tap count: \(tapCount)") {
                        tapCount += 1
                    }
                    TextField("Enter your name", text: $name)
                    Picker("Choose your name", selection: $selectedName) {
                        ForEach(names, id: \.self) {
                            Text($0)
                        }
                    }
                    
                } header: {
                    Text("Other")
                        .textCase(nil)
                }

            }
            .navigationTitle("SwiftUI")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
