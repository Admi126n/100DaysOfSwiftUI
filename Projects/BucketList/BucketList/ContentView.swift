//
//  ContentView.swift
//  BucketList
//
//  Created by Adam Tokarski on 26/10/2023.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct Location: Identifiable {
	var id = UUID()
	let name: String
	let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
	@State private var isUnlocked = false
	@State private var mapCameraPosition = MapCameraPosition.region(
		MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: 50.1, longitude: 18.22),
			span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
	)
	
	let locations = [
		Location(name: "Pinezka 1", coordinate: CLLocationCoordinate2D(latitude: 50.1, longitude: 18.22)),
		Location(name: "Pinezka 2", coordinate: CLLocationCoordinate2D(latitude: 50.13, longitude: 18.23)),
		Location(name: "Pinezka 3", coordinate: CLLocationCoordinate2D(latitude: 50.08, longitude: 18.21))
	]
	
	var body: some View {
		Map(initialPosition: mapCameraPosition) {
			if isUnlocked {
				ForEach(locations) { location in
					Annotation(location.name, coordinate: location.coordinate) {
						Circle()
							.stroke(.red, lineWidth: 3)
							.frame(width: 44, height: 44)
							.onTapGesture {
								print(location.name)
							}
						
					}
				}
			}
		}
		.onAppear(perform: authenticate)
	}
	
	private func authenticate() {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "We need to unlock your data"
			
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				
				if success {
					isUnlocked = true
				} else {
					// failure
				}
			}
		} else {
			// no biometry
		}
	}
}

#Preview {
	ContentView()
}
