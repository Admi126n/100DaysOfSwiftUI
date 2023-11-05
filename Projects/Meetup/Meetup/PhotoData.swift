//
//  PhotoData.swift
//  Meetup
//
//  Created by Adam Tokarski on 04/11/2023.
//

import UIKit

struct PhotoData: Identifiable, Comparable, Codable {
	var id = UUID()
	let imageData: Data
	let description: String
	let latitude: Double
	let longitude: Double
	
	var image: UIImage {
		UIImage(data: imageData)!
	}
	
	static func < (lhs: PhotoData, rhs: PhotoData) -> Bool {
		lhs.description < rhs.description
	}
}
