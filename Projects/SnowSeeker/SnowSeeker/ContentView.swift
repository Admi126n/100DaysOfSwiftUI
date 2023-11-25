//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
	let resorts: [Resort] = Bundle.main.decode("resorts.json")
	
	@StateObject var favorites = Favorites()
	@State private var searchText = ""
	
	var filteredResorts: [Resort] {
		if searchText.isEmpty {
			return resorts
		} else {
			return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
		}
	}
	
	var body: some View {
		NavigationSplitView(columnVisibility: .constant(.all)) {
			List(filteredResorts) { resort in
				NavigationLink {
					ResortView(of: resort)
				} label: {
					HStack {
						Image(resort.country)
							.resizable()
							.scaledToFill()
							.frame(width: 40, height: 25)
							.clipShape(.rect(cornerRadius: 5))
							.overlay(RoundedRectangle(cornerRadius: 5).stroke(.black, lineWidth: 1))
						
						VStack(alignment: .leading) {
							Text(resort.name)
								.font(.headline)
							
							Text("\(resort.runs) runs")
								.foregroundStyle(.secondary)
						}
						
						if favorites.contains(resort) {
							Spacer()
							Image(systemName: "heart.fill")
								.accessibilityLabel("This is a favorite resort")
								.foregroundStyle(.red)
						}
					}
				}
			}
			.toolbar(removing: .sidebarToggle)
			.navigationTitle("Resorts")
			.searchable(text: $searchText, prompt: "Search for a resort")
		} detail: {
			WelcomeView()
		}
		.navigationSplitViewStyle(.balanced)
		.environmentObject(favorites)
	}
}

#Preview {
	ContentView()
}
