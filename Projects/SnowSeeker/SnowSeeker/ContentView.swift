//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 23/11/2023.
//

import SwiftUI

@frozen
fileprivate enum SortType {
	case defaultOrder
	case alphabetical
	case country
}

struct ContentView: View {
	let resorts: [Resort] = Bundle.main.decode("resorts.json")
	
	@StateObject var favorites = Favorites()
	@State private var searchText = ""
	@State private var sortType: SortType = .country
	@State private var showingDialog = false
	
	var filteredResorts: [Resort] {
		if searchText.isEmpty {
			return resorts
		} else {
			return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
		}
	}
	
	var sortedResorts: [Resort] {
		switch sortType {
		case .defaultOrder:
			return filteredResorts
		case .alphabetical:
			return filteredResorts.sorted { $0.name < $1.name }
		case .country:
			return filteredResorts.sorted { $0.country < $1.country }
		}
	}
	
	var body: some View {
		NavigationSplitView(columnVisibility: .constant(.all)) {
			List(sortedResorts) { resort in
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
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button("Sort type", systemImage: "arrow.up.arrow.down") {
						showingDialog = true
					}
				}
			}
			.navigationTitle("Resorts")
			.searchable(text: $searchText, prompt: "Search for a resort")
		} detail: {
			WelcomeView()
		}
		.navigationSplitViewStyle(.balanced)
		.environmentObject(favorites)
		.confirmationDialog("Choose sorting type", isPresented: $showingDialog) {
			Button("Default") {
				sortType = .defaultOrder
				print(sortType)
			}
			Button("Alphabetical") {
				sortType = .alphabetical
				print(sortType)
			}
			Button("By country") {
				sortType = .country
				print(sortType)
			}
		} message: {
			Text("Choose sorting type")
		}
	}
}

#Preview {
	ContentView()
}
