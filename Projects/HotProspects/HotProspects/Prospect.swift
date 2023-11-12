//
//  Prospect.swift
//  HotProspects
//
//  Created by Adam Tokarski on 09/11/2023.
//

import SwiftUI

class Prospect: Identifiable, Codable {
	var id = UUID()
	var name = "Anonymous"
	var emailAddress = ""
	var addedDate: Date = .now
	fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
	@Published private(set) var people: [Prospect]
	private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProspects")
	private let saveKey = "SavedData"
	
	init() {
		do {
			let data = try Data(contentsOf: savePath)
			people = try JSONDecoder().decode([Prospect].self, from: data)
		} catch {
			self.people = []
		}
	}
	
	private func save() {
		do {
			let data = try JSONEncoder().encode(people)
			try data.write(to: savePath, options: [.atomic, .completeFileProtection])
		} catch {
			print("Unable to save data, \(error.localizedDescription)")
		}
	}
	
	func add(_ prospect: Prospect) {
		people.append(prospect)
		save()
	}
	
	func toggle(_ prospect: Prospect) {
		objectWillChange.send()
		prospect.isContacted.toggle()
		save()
	}
}
