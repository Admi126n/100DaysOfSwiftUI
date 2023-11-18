//
//  Card.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 15/11/2023.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
	var id = UUID()
	let prompt: String
	let answer: String
	
	var copy: Card {
		return Card(prompt: self.prompt, answer: self.answer)
	}
	
	static let example = Card(prompt: "Who player the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
