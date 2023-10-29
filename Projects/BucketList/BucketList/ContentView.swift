//
//  ContentView.swift
//  BucketList
//
//  Created by Adam Tokarski on 26/10/2023.
//

import MapKit
import SwiftUI

struct ContentView: View {
//	private static let initLat = 50.09
//	private static let initLon = 18.22
	private static let initLat = 50.09
	private static let initLon = 18.22
	
	@State private var mapCameraPosition: MapCameraPosition = .region(
		MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: initLat, longitude: initLon),
			span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
	)
	@State private var cameraCenter = CLLocationCoordinate2D(latitude: initLat, longitude: initLon)
	@State private var locations: [Location] = []
	@State private var selectedPlace: Location?
	
	var body: some View {
		ZStack {
			Map(position: $mapCameraPosition) {
				ForEach(locations) { location in
					Annotation(location.name, coordinate: location.coordinate) {
						Image(systemName: "star.circle")
							.resizable()
							.foregroundStyle(.red)
							.frame(width: 44, height: 44)
							.background(.white)
							.clipShape(.circle)
							.onTapGesture {
								selectedPlace = location
							}
					}
				}
			}
			.ignoresSafeArea()
			.onMapCameraChange { mapCameraUpdateContext in
				cameraCenter = mapCameraUpdateContext.camera.centerCoordinate
			}
			
			Circle()
				.fill(.blue)
				.opacity(0.3)
				.frame(width: 32, height: 32)
			
			VStack {
				Spacer()
				
				HStack {
					Spacer()
					
					Button {
						let newLocation = Location(
							id: UUID(),
							name: "New location",
							description: "",
							latitude: cameraCenter.latitude,
							longitude: cameraCenter.longitude
						)
						
						locations.append(newLocation)
						
					} label: {
						Image(systemName: "plus")
					}
					.padding()
					.background(.black.opacity(0.75))
					.foregroundStyle(.white)
					.font(.title)
					.clipShape(.circle)
					.padding(.trailing)
				}
			}
		}
		.sheet(item: $selectedPlace) { place in
			EditView(location: place) { newLocation in
				if let index = locations.firstIndex(of: place) {
					locations[index] = newLocation
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
