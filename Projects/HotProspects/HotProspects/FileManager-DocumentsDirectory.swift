//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Adam Tokarski on 12/11/2023.
//

import Foundation

extension FileManager {
	static var documentsDirectory: URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	func decode(_ file: String) -> String {
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let url = path.appendingPathComponent(file)
		
		guard let data = try? String(contentsOf: url) else { fatalError("Cannot read data") }
		
		return data
	}
}
