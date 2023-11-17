//
//  ContentView.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 13/11/2023.
//

import SwiftUI

extension View {
	func stacked(at position: Int, in total: Int) -> some View {
		let offset = Double(total - position)
		
		return self.offset(y: offset * 10)
	}
}

struct ContentView: View {
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	@Environment(\.scenePhase) var scenePhase
	@Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
	@State private var cards: [Card] = []
	@State private var isActive = true
	@State private var showingEditScreen = false
	@State private var timeRamaining = 100
	
	var body: some View {
		ZStack {
			Image(.background)
				.resizable()
				.ignoresSafeArea()
			
			VStack {
				Text("Time: \(timeRamaining)")
					.font(.largeTitle)
					.foregroundStyle(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.black.opacity(0.75))
					.clipShape(.capsule)
				
				ZStack {
					ForEach(0..<cards.count, id: \.self) { index in
						CardView(card: cards[index]) {
							withAnimation {
								removeCard(at: index)
							}
						}
						.stacked(at: index, in: cards.count)
						.allowsTightening(index == cards.count - 1)
						.accessibilityHidden(index < cards.count - 1)
					}
				}
				.allowsTightening(timeRamaining > 0)
				
				if cards.isEmpty {
					Button("Start again", action: resetCards)
						.padding()
						.background(.white)
						.foregroundStyle(.black)
						.clipShape(.capsule)
				}
			}
			
			VStack {
				HStack {
					Spacer()
					
					Button {
						showingEditScreen = true
					} label: {
						Image(systemName: "plus.circle")
							.padding()
							.background(.black.opacity(0.7))
							.clipShape(.circle)
					}
				}
			
				Spacer()
			}
			.foregroundStyle(.white)
			.font(.largeTitle)
			.padding()
			
			if differentiateWithoutColor || voiceOverEnabled {
				VStack {
					Spacer()
					
					HStack {
						Button {
							withAnimation {
								removeCard(at: cards.count - 1)
							}
						} label: {
							Image(systemName: "xmark.circle")
								.padding()
								.background(.black.opacity(0.7))
								.clipShape(.circle)
						}
						.accessibilityLabel("Wrong")
						.accessibilityHint("Mark your answer as being incorrect")
						
						Spacer()
						
						Button {
							withAnimation {
								removeCard(at: cards.count - 1)
							}
						} label: {
							Image(systemName: "checkmark.circle")
								.padding()
								.background(.black.opacity(0.7))
								.clipShape(.circle)
						}
						.accessibilityLabel("Correct")
						.accessibilityHint("Mark your answer as being correct")
					}
					.foregroundStyle(.white)
					.font(.largeTitle)
					.padding()
				}
			}
		}
		.onReceive(timer) { time in
			guard isActive else { return }
			
			if timeRamaining > 0 {
				timeRamaining -= 1
			}
		}
		.onChange(of: scenePhase) {
			guard !cards.isEmpty else { return }
			
			isActive = scenePhase == .active
		}
		.sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
		.onAppear(perform: resetCards)
	}
	
	private func loadData() {
		if let data = UserDefaults.standard.data(forKey: "Cards") {
			if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
				cards = decoded
			}
		}
	}
	
	private func removeCard(at index: Int) {
		guard index >= 0 else { return }
		
		cards.remove(at: index)
		
		if cards.isEmpty {
			isActive = false
		}
	}
	
	private func resetCards() {
		timeRamaining = 100
		isActive = true
		loadData()
	}
}

#Preview {
	ContentView()
}
