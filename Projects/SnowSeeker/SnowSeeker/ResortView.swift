//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 24/11/2023.
//

import SwiftUI

struct ResortView: View {
	let resort: Resort
	
	@Environment(\.dynamicTypeSize) var typeSize
	@Environment(\.horizontalSizeClass) var sizeClass
	
	@EnvironmentObject var favorites: Favorites
	
	@State private var selectedFacility: Facility?
	@State private var showingFacility = false
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				Image(decorative: resort.id)
					.resizable()
					.scaledToFit()
				
				HStack {
					if sizeClass == .compact && typeSize > .large {
						VStack(spacing: 10) { ResortDeailsView(of: resort) }
						VStack(spacing: 10) {SkiDetailsView(of: resort) }
					} else {
						ResortDeailsView(of: resort)
						SkiDetailsView(of: resort)
					}
				}
				.padding(.vertical)
				.background(Color.primary.opacity(0.1))
				.dynamicTypeSize(...DynamicTypeSize.xxxLarge)
				
				Group {
					Text(resort.description)
						.padding(.vertical)
					
					Text("Facilities")
						.font(.headline)
					
					HStack {
						ForEach(resort.facilityTypes) { facility in
							Button {
								selectedFacility = facility
								showingFacility = true
							} label: {
								facility.icon
									.font(.title)
							}
						}
					}
					
					
					
					
					Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
						if favorites.contains(resort) {
							favorites.remove(resort)
						} else {
							favorites.add(resort)
						}
					}
					.buttonStyle(.borderedProminent)
					.padding()
				}
				.padding(.horizontal)
				
			}
		}
		.navigationTitle("\(resort.name), \(resort.country)")
		.navigationBarTitleDisplayMode(.inline)
		.alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
			
		} message: { facility in
			Text(facility.description)
		}
    }
	
	init(of resort: Resort) {
		self.resort = resort
	}
}

#Preview {
	NavigationStack {
		ResortView(of: Resort.example)
	}
	.environmentObject(Favorites())
}
