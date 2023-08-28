//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adam Tokarski on 28/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showHelloAlert = false
    @State private var showCustomAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [.init(color: .green, location: 0.3),
                .init(color: .blue, location: 0.7)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("Hello world!")
                    .foregroundStyle(.secondary)
                
                Button("Click me") {
                    showHelloAlert = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                .alert("Hello!", isPresented: $showHelloAlert) {
                    Button("Hi!") { }
                }
                
                Button {
                    showCustomAlert = true
                } label: {
                    Label("Custom button", systemImage: "pencil")
                }
                .alert("I'm more customized alert", isPresented: $showCustomAlert) {
                    Button("Delete", role: .destructive) { }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("I have two buttons")
                }
            }
            .padding(50)
            .background(.ultraThinMaterial)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
