//
//  ContentView.swift
//  DiceRoller
//
//  Created by Adam Tokarski on 22/11/2023.
//

import SwiftUI

fileprivate struct DiceParameters: View {
	private let diceSizes = [4, 6, 8, 10, 12, 20, 100]
	
	@Binding var diceSize: Int
	@Binding var diceCount: Int
	
	var body: some View {
		Section("Roll parameters") {
			Stepper("Number of dices: \(diceCount)", value: $diceCount, in: 1...10)
			Picker("Dice size", selection: $diceSize) {
				ForEach(diceSizes, id: \.self) { Text("\($0)") }
			}
		}
	}
}

struct ContentView: View {
	let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
	@State private var timerCounter = 0
	@State private var timerFlag = false
	
	@State private var results: [[String]] = []
	@State private var diceSize = 6
	@State private var diceCount = 1
	@State private var hapticFeedback = UINotificationFeedbackGenerator()
	@State private var randomNumber = "1"
	
	var body: some View {
		NavigationStack {
			List {
				DiceParameters(diceSize: $diceSize, diceCount: $diceCount)
				
				Section("Results") {
					ForEach(results, id: \.self) { result in
						Text(result.joined(separator: ", "))
					}
					.onDelete(perform: deleteResult)
				}
			}
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button("Roll", systemImage: "dice") {
						withAnimation {
							results.insert([], at: 0)
						}
						timerFlag = true
					}
					.disabled(timerFlag)
				}
			}
		}
		.onAppear(perform: load)
		.onReceive(timer) { _ in
			if timerFlag {
				rollEffect()
			}
		}
	}
	
	private func rollEffect() {
		var rollResults: [String] = []
		
		for _ in 1...diceCount {
			rollResults.append("\(Int.random(in: 1...diceSize))")
		}
		
		withAnimation {
			results[0] = rollResults
		}
		
		timerCounter += 1
		if timerCounter == 7 {
			timerFlag = false
			timerCounter = 0
			roll()
		}
	}
	
	private func roll() {
		hapticFeedback.prepare()
		
		var rollResults: [String] = []
		
		for _ in 1...diceCount {
			rollResults.append("\(Int.random(in: 1...diceSize))")
		}
		
		withAnimation {
			results[0] = rollResults.sorted(by: { Int($0)! < Int($1)! })
		}
		
		hapticFeedback.notificationOccurred(.success)
		save()
	}
	
	private func save() {
		var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		path = path.appendingPathComponent("Results")
		
		if let encoded = try? JSONEncoder().encode(results) {
			try? encoded.write(to: path, options: [.atomic])
		}
	}
	
	private func load() {
		var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		path = path.appendingPathComponent("Results")
		
		if let data = try? Data(contentsOf: path) {
			if let decoded = try? JSONDecoder().decode([[String]].self, from: data) {
				Task { @MainActor in
					results = decoded
				}
			}
		}
	}
	
	private func deleteResult(at offsets: IndexSet) {
		results.remove(atOffsets: offsets)
		save()
	}
}

#Preview {
	ContentView()
}
