//
//  ContentView.swift
//  BucketList
//
//  Created by Adam Tokarski on 26/10/2023.
//

import MapKit
import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = ViewModel()
	@State private var showAlert = false
	@State private var alertMessage = ""
	
	var body: some View {
		if viewModel.isUnlocked {
			ZStack {
				Map(position: $viewModel.mapCameraPosition) {
					ForEach(viewModel.locations) { location in
						Annotation(location.name, coordinate: location.coordinate) {
							Image(systemName: "star.circle")
								.resizable()
								.foregroundStyle(.red)
								.frame(width: 44, height: 44)
								.background(.white)
								.clipShape(.circle)
								.onTapGesture {
									viewModel.selectedPlace = location
								}
						}
					}
				}
				.ignoresSafeArea()
				.onMapCameraChange { mapCameraUpdateContext in
					viewModel.cameraCenter = mapCameraUpdateContext.camera.centerCoordinate
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
							viewModel.addLocation()
						} label: {
							Image(systemName: "plus")
								.padding()
								.background(.black.opacity(0.75))
								.foregroundStyle(.white)
								.font(.title)
								.clipShape(.circle)
								.padding(.trailing)
						}
					}
				}
			}
			.sheet(item: $viewModel.selectedPlace) { place in
				EditView(location: place) { newLocation in
					viewModel.update(location: newLocation)
				}
			}
		} else {
			Button("Unlock places") {
				viewModel.authenticate { message in
					if let message = message {
						alertMessage = message
						showAlert = true
					}
				}
			}
			.padding()
			.background(.blue)
			.foregroundStyle(.white)
			.clipShape(.capsule)
			.alert("Something went wrong", isPresented: $showAlert) {
				Button("OK") { }
			} message: {
				Text(alertMessage)
			}
		}
	}
}

#Preview {
	ContentView()
}
