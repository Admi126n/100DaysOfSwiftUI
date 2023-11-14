//
//  ContentView.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 13/11/2023.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
	if UIAccessibility.isReduceMotionEnabled {
		return try body()
	} else {
		return try withAnimation(animation, body)
	}
}

struct ContentView: View {
//	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//	@Environment(\.accessibilityReduceMotion) var reduceMotion
	@Environment(\.accessibilityReduceTransparency) var reduceTransparency
	@State private var scale = 1.0
	
	var body: some View {
		Text("Hello, Wordl!")
			.padding()
			.background(reduceTransparency ? .black : .black.opacity(0.5))
			.foregroundStyle(.white)
			.clipShape(.capsule)
		
//			.scaleEffect(scale)
//			.onTapGesture {
//				withOptionalAnimation {
//					scale *= 1.5
//				}
//			}
	}
	
// 2
//	@Environment(\.scenePhase) var scenePhase
//	var body: some View {
//		Text("Hello, World!")
//			.onChange(of: scenePhase) {
//				switch scenePhase {
//				case .background:
//					print("Background")
//				case .inactive:
//					print("Inactive")
//				case .active:
//					print("Active")
//				@unknown default:
//					print("IDK what happened here")
//					fatalError("Unknown case")
//				}
//			}
//	}

// 1
//	let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
//	@State private var counter = 0
//	var body: some View {
//		Text("Hello, World!")
//			.onReceive(timer) { time in
//				if counter == 5 {
//					timer.upstream.connect().cancel()
//				} else {
//					print("The time is \(time)")
//				}
//				
//				counter += 1
//			}
//	}
}

#Preview {
    ContentView()
}
