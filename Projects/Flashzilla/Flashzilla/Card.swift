//
//  Card.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 15/11/2023.
//

import Foundation

struct Card: Codable {
	let prompt: String
	let answer: String
	
	static let example = Card(prompt: "Who player the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
