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
	
	init() {
		// load saved data
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
		// write out our data
	}
}
