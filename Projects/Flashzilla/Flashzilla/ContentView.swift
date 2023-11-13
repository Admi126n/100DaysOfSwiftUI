//
//  ContentView.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 13/11/2023.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
// 2
//	@State private var currentAmount = Angle.zero
//	@State private var finalAmount = Angle.zero

// 1
//	@State private var currentAmount = 0.0
//	@State private var finalAmount = 1.0
	@State private var counter = 0
	@State private var engine: CHHapticEngine?
	
	var body: some View {
		ZStack {
			Rectangle()
				.fill(.blue)
				.frame(width: 300, height: 300)
				.onTapGesture {
					print("Rectangle tapped")
				}
			
			Circle()
				.fill(.red)
				.frame(width: 300, height: 300)
				.contentShape(.rect)
				.onTapGesture {
					print("Circle tapped")
				}
				
		}
		
//		Button("Play haptic", action: complexSuccess)
//		.onAppear(perform: prepareHaptics)
	}
		
	private func prepareHaptics() {
		guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
		
		do {
			engine = try CHHapticEngine()
			try engine?.start()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private func complexSuccess() {
		guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
		
		var events = [CHHapticEvent]()
		
		for i in stride(from: 0, to: 1, by: 0.1) {
			let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
			let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
			let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
			events.append(event)
		}
		
		for i in stride(from: 0, to: 1, by: 0.1) {
			let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
			let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
			let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
			events.append(event)
		}
		
		do {
			let pattern = try CHHapticPattern(events: events, parameters: [])
			let player = try engine?.makePlayer(with: pattern)
			try player?.start(atTime: 0)
		} catch {
			print(error.localizedDescription)
		}
	}
		
//		.sensoryFeedback(.impact(flexibility: .soft, intensit y: 0.5), trigger: counter)
//		.sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
//		.sensoryFeedback(.increase, trigger: counter)
		
// 2
//		.rotationEffect(currentAmount + finalAmount)
//		.gesture(
//			RotationGesture()
//				.onChanged { angle in
//					currentAmount = angle
//				}
//				.onEnded { angle in
//					finalAmount += currentAmount
//					currentAmount = .zero
//				}
//		)
		
// 1
//		.scaleEffect(finalAmount + currentAmount)
//		.gesture(
//			MagnifyGesture()
//				.onChanged { amount in
//					currentAmount = amount.magnification - 1
//				}
//				.onEnded { amount in
//					finalAmount += currentAmount
//					currentAmount = 0
//				}
//		)

}

#Preview {
    ContentView()
}
