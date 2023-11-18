//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 18/11/2023.
//

import Foundation

extension FileManager {
	private static var documentsDirectory: URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	static func loadData<T: Codable>(from key: String) -> T? {
		let loadPath = documentsDirectory.appendingPathComponent(key)
		
		do {
			let data = try Data(contentsOf: loadPath)
			let decoded = try JSONDecoder().decode(T.self, from: data)
			
			return decoded
		} catch {
			print("Cannot load data, \(error.localizedDescription)")
		}
		
		return nil
	}
	
	static func save<T: Codable>(_ data: T, to key: String) {
		let savePath = documentsDirectory.appendingPathComponent(key)
		
		do {
			let encoded = try JSONEncoder().encode(data)
			try encoded.write(to: savePath, options: [.atomic])
		} catch {
			print("Cannot save data, \(error.localizedDescription)")
		}
	}
	
}
