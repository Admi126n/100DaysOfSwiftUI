//
//  Location.swift
//  BucketList
//
//  Created by Adam Tokarski on 28/10/2023.
//

import CoreLocation
import Foundation

struct Location: Identifiable, Codable, Equatable {
	var id: UUID
	var name: String
	var description: String
	let latitude: Double
	let longitude: Double
	
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	static let example = Location(id: UUID(),
								  name: "Raciborz",
								  description: "Small town in Silesia",
								  latitude: 50.09,
								  longitude: 18.22
	)
	
	static func ==(lhs: Location, rhs: Location) -> Bool {
		lhs.id == rhs.id
	}
}
