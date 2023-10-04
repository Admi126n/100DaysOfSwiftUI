//
//  ContentView.swift
//  Drawing
//
//  Created by Adam Tokarski on 01/10/2023.
//

import SwiftUI

struct Arrow: Shape {
    var lineWidth = 60.0
    
    var animatableData: CGFloat {
        get { lineWidth }
        set { lineWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - lineWidth, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - lineWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + lineWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + lineWidth, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targerHue = Double(value) / Double(steps) + amount
        
        if targerHue > 1 {
            targerHue -= 1
        }
        
        return Color(hue: targerHue, saturation: 1, brightness: brightness)
    }
    
}

struct ColorCyclingRectangle: View {
    var gradientStartPoint: UnitPoint
    var gradientEndPoint: UnitPoint
    
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.2)
                            ]),
                            startPoint: gradientStartPoint,
                            endPoint: gradientEndPoint
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targerHue = Double(value) / Double(steps) + amount
        
        if targerHue > 1 {
            targerHue -= 1
        }
        
        return Color(hue: targerHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineWidth = 60.0
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            Arrow(lineWidth: lineWidth)
                .fill(.red)
                .onTapGesture {
                    withAnimation {
                        lineWidth = Double.random(in: 10...100)
                    }
                }
                .padding()
            
            Spacer()
            
            ColorCyclingRectangle(
                gradientStartPoint: .center,
                gradientEndPoint: .top,
                amount: amount
            )
            .padding()
            
            Spacer()
            
            Group {
                Text("Arrow line width: \(lineWidth, format: .number.precision(.fractionLength(2)))")
                Slider(value: $lineWidth, in: 10...100)
                    .padding()
                
                Text("Rectangle amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount, in: 0...1)
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
