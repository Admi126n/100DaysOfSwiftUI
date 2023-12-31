//
//  EditCards.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 17/11/2023.
//

import SwiftUI

struct EditCards: View {
	@Environment(\.dismiss) var dismiss
	@State private var cards: [Card] = []
	@State private var newAnswer = ""
	@State private var newPrompt = ""
	
    var body: some View {
		NavigationStack {
			List {
				Section("Add new card") {
					TextField("Prompt", text: $newPrompt)
					TextField("Answer", text: $newAnswer)
					Button("Add card", action: addCard)
				}
				
				Section {
					ForEach(0..<cards.count, id: \.self) { index in
						VStack(alignment: .leading) {
							Text(cards[index].prompt)
								.font(.headline)
							
							Text(cards[index].answer)
								.foregroundStyle(.secondary)
						}
					}
					.onDelete(perform: removeCards)
				}
			}
			.navigationTitle("Edit cards")
			.toolbar {
				Button("Done", action: done)
			}
			.listStyle(.grouped)
			.onAppear(perform: loadData)
		}
    }
	
	private func done() {
		dismiss()
	}
	
	private func loadData() {
		if let loadedCards: [Card] = FileManager.loadData(from: "Cards") {
			cards = loadedCards
		} else {
			cards = []
		}
	}
	
	private func save() {
		FileManager.save(cards, to: "Cards")
	}
	
	private func addCard() {
		let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
		let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
		
		guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
		
		let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
		withAnimation {
			newPrompt = ""
			newAnswer = ""
		}
		
		cards.insert(card, at: 0)
		save()
	}
	
	private func removeCards(at offsets: IndexSet) {
		cards.remove(atOffsets: offsets)
		save()
	}
}

#Preview {
    EditCards()
}
