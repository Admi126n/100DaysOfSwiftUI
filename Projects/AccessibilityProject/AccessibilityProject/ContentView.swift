//
//  ContentView.swift
//  AccessibilityProject
//
//  Created by Adam Tokarski on 01/11/2023.
//

import SwiftUI

struct ContentView: View {
	@State private var value = 10
	
	var body: some View {
		VStack {
			Text("Value: \(value)")
			
			Button("Increment") {
				value += 1
			}
			
			Button("Decrement") {
				value -= 1
			}
		}
		.accessibilityElement()
		.accessibilityLabel("Value")
		.accessibilityValue(String(value))
		.accessibilityAdjustableAction { direction in
			switch direction {
			case .increment:
				value += 1
			case .decrement:
				value -= 1
			default:
				print("Not handled")
			}
		}
	}
	
// 2
//	var body: some View {
//		VStack {
//			Text("Your score is")
//			Text("1000")
//				.font(.title)
//		}
//		.accessibilityElement(children: .ignore)
//		.accessibilityLabel("Your score is 1000")
//	}
	
// 1
//	let pictures = [
//		Image(.alesKrivec15949),
//		Image(.galinaN189483),
//		Image(.kevinHorstmann141705),
//		Image(.nicolasTissot335096)
//	]
//	let labels = [
//		"Tulips",
//		"Frozen tree buds",
//		"Sunflowers",
//		"Fireworks"
//	]
//	@State private var selectedPicture = Int.random(in: 0...3)
//    var body: some View {
//		pictures[selectedPicture]
//			.resizable()
//			.scaledToFit()
//			.onTapGesture {
//				selectedPicture = Int.random(in: 0...3)
//			}
//			.accessibilityLabel(labels[selectedPicture])
//			.accessibilityAddTraits(.isButton)
//			.accessibilityRemoveTraits(.isImage)
//    }
}

#Preview {
    ContentView()
}
