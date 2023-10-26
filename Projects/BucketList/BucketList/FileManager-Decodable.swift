//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by Adam Tokarski on 26/10/2023.
//

import Foundation

extension FileManager {
	func decode(_ file: String) -> String {
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let url = path.appendingPathComponent(file)
		
		guard let data = try? String(contentsOf: url) else { fatalError("Cannot read data") }
		
		return data
	}
}
