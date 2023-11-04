//
//  FileManager-DocumentsDirectory.swift
//  Meetup
//
//  Created by Adam Tokarski on 04/11/2023.
//

import Foundation

extension FileManager {
	static var documentsDirectory: URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
}
