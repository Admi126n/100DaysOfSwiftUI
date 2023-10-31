//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Adam Tokarski on 30/10/2023.
//

import MapKit
import LocalAuthentication
import SwiftUI

extension ContentView {
	// @MainActor - every part of this class should run in main actor
	@MainActor class ViewModel: ObservableObject {
		private static let initLat = 50.09
		private static let initLon = 18.22
		
		@Published var mapCameraPosition: MapCameraPosition = .region(
			MKCoordinateRegion(
				center: CLLocationCoordinate2D(latitude: initLat, longitude: initLon),
				span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
		)
		@Published var cameraCenter = CLLocationCoordinate2D(latitude: initLat, longitude: initLon)
		@Published private(set) var locations: [Location]
		@Published var selectedPlace: Location?
		@Published var isUnlocked = false
		
		let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
		
		init() {
			do {
				let data = try Data(contentsOf: savePath)
				locations = try JSONDecoder().decode([Location].self, from: data)
			} catch {
				locations = []
			}
		}
		
		func save() {
			do {
				let data = try JSONEncoder().encode(locations)
				try data.write(to: savePath, options: [.atomic, .completeFileProtection])
			} catch {
				print("Unable to save data: \(error.localizedDescription)")
			}
		}
		
		func addLocation() {
			let newLocation = Location(
				id: UUID(),
				name: "New location",
				description: "",
				latitude: cameraCenter.latitude,
				longitude: cameraCenter.longitude
			)
			
			locations.append(newLocation)
			save()
		}
		
		func update(location: Location) {
			guard let selectedPlace = selectedPlace else { return }
			
			if let index = locations.firstIndex(of: selectedPlace) {
				locations[index] = location
				save()
			}
		}
		
		func authenticate(_ compleationHandler: @escaping (String?) -> ()) {
			let context = LAContext()
			var error: NSError?
			
			if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
				let reason = "Please authenticate yourself to unlock your places."
				
				context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
					if success {
						// here we have to say run it at the main actor because this closure is runed from context and can be runned in background
						Task { @MainActor in
							self.isUnlocked = true
						}
					} else {
						compleationHandler("Cannot authenticate.")
					}
				}
			} else {
				compleationHandler("Biometrics not available.")
			}
		}
	}
}
