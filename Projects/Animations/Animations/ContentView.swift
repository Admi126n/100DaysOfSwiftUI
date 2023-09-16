//
//  ContentView.swift
//  Animations
//
//  Created by Adam Tokarski on 16/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount_1 = 0.0
    @State private var animationAmount_2 = 0.0
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation(.easeOut(duration: 4)) {
                    animationAmount_1 += 360
                }
            }
            .padding(50)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount_1), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
            
            Button("Tap me") {
            }
            .padding(50)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.blue)
                    .scaleEffect(animationAmount_2)
                    .opacity(2 - animationAmount_2)
                    .animation(
                        .easeInOut(duration: 2)
                        .repeatForever(autoreverses: false),
                        value: animationAmount_2
                    )
            )
            .onAppear {
                animationAmount_2 = 2
            }
        }
    }
    
    //    @State private var animationAmount = 1.0
    //    var body: some View {
    //        print(animationAmount)
    //
    //        return VStack {
    //            Stepper("Scale amount", value: $animationAmount.animation(
    //                .easeInOut(duration: 0.5)
    //                .repeatCount(3, autoreverses: true)
    //            ), in: 1...10)
    //                .padding()
    //
    //            Spacer()
    //
    //            Button("Tap me") {
    //                animationAmount += 1
    //            }
    //            .padding(50)
    //            .background(.red)
    //            .foregroundColor(.white)
    //            .clipShape(Circle())
    //            .scaleEffect(animationAmount)
    //        }
    //    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
