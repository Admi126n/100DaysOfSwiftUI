//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 25/11/2023.
//

import Foundation

class Favorites: ObservableObject {
	private var resorts: Set<String>
	private let saveKey = "Favorites"
	private let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
	
	init() {
		if let data = try? Data(contentsOf: dataPath.appending(path: saveKey)) {
			if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
				resorts = decoded
				return
			}
		}
		
		resorts = []
	}
	
	func contains(_ resort: Resort) -> Bool {
		resorts.contains(resort.id)
	}
	
	func add(_ resort: Resort) {
		objectWillChange.send()
		resorts.insert(resort.id)
		save()
	}
	
	func remove(_ resort: Resort) {
		objectWillChange.send()
		resorts.remove(resort.id)
		save()
	}
	
	func save() {
		do {
			let encoded = try JSONEncoder().encode(resorts)
			try encoded.write(to: dataPath.appending(path: saveKey), options: [.atomic])
		} catch {
			print(error.localizedDescription)
		}
	}
}
