//
//  ContentView.swift
//  HotProspects
//
//  Created by Adam Tokarski on 06/11/2023.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
	var value = 0 {
		willSet {
			objectWillChange.send()
		}
	}
	
	init() {
		for i in 1...10 {
			DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
				self.value += 1
			}
		}
	}
}

struct ContentView: View {
	var body: some View {
		VStack {
			Image(.example)
				.interpolation(.none)
				.resizable()
				.scaledToFit()
				.frame(maxHeight: .infinity)
				.background(.black)
				.ignoresSafeArea()
		}
	}
	
// 2
//	@State private var output = ""
//	var body: some View {
//		Text(output)
//			.task {
//				await fetchReadings()
//			}
//	}
//	
//	private func fetchReadings() async {
//		let fetchTask = Task { () -> String in
//			let url = URL(string: "https://hws.dev/readings.json")!
//			let (data, _) = try await URLSession.shared.data(from: url)
//			let readings = try JSONDecoder().decode([Double].self, from: data)
//			
//			return "Found \(readings.count) readings"
//		}
//		
//		let result = await fetchTask.result
//		
//		switch result {
//		case .success(let success):
//			output = success
//		case .failure(let failure):
//			output = "Download error \(failure.localizedDescription)"
//		}
//	}
	
// 1
//	@StateObject var updater = DelayedUpdater()
//	var body: some View {
//		Text("Value is: \(updater.value)")
//	}
}

#Preview {
	ContentView()
}
