//
//  ContentView.swift
//  Instafilter
//
//  Created by Adam Tokarski on 20/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showDialog = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello world")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showDialog = true
            }
            .confirmationDialog("Change background", isPresented: $showDialog) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
    }
    
// 1
//    @State private var blurAmount = 0.0
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//                .blur(radius: blurAmount)
//            
//            Text("Hello, world!")
//                .blur(radius: blurAmount)
//            
//            Slider(value: $blurAmount, in: 0...20)
//                .onChange(of: blurAmount) {
//                    print("New value is \(blurAmount)")
//                }
//            
//            Button("Random blur") {
//                withAnimation {
//                    blurAmount = Double.random(in: 0...20)
//                }
//            }
//        }
//        .padding()
//    }
}

#Preview {
    ContentView()
}
