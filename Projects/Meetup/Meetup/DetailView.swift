//
//  DetailView.swift
//  Meetup
//
//  Created by Adam Tokarski on 04/11/2023.
//

import MapKit
import SwiftUI

struct DetailView: View {
	var photoData: PhotoData
	
	var mapCameraPosition: MapCameraPosition { .region(
		MKCoordinateRegion(
			center: CLLocationCoordinate2D(latitude: photoData.latitude, longitude: photoData.longitude),
			span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
		}
	
    var body: some View {
		NavigationStack {
			VStack {
				Image(uiImage: photoData.image)
					.resizable()
					.scaledToFit()
					.clipShape(.rect(cornerRadius: 20))
				
				Map(initialPosition: mapCameraPosition) {
					Marker(photoData.description, coordinate: CLLocationCoordinate2D(latitude: photoData.latitude, longitude: photoData.longitude))
				}
				.clipShape(.rect(cornerRadius: 20))
			}
		}
    }
	
	init(of photoData: PhotoData) {
		self.photoData = photoData
	}
}
