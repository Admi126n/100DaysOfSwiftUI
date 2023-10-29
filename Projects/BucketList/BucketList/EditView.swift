//
//  EditView.swift
//  BucketList
//
//  Created by Adam Tokarski on 28/10/2023.
//

import SwiftUI

struct EditView: View {
	enum LoadingState {
		case loading
		case loaded
		case failed
	}
	
	@Environment(\.dismiss) var dismiss
	var location: Location
	var onSave: (Location) -> Void
	
	@State private var name: String
	@State private var description: String
	
	@State private var loadingState: LoadingState = .loading
	@State private var pages: [Page] = []
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Place name", text: $name)
					TextField("Place descriprion", text: $description)
				}
				
				Section("Nearby") {
					switch loadingState {
					case .loading:
						Text("Loading...")
					case .loaded:
						ForEach(pages, id: \.pageid) { page in
							Text(page.title)
								.font(.headline)
							+ Text(": ")
							+ Text(page.description)
								.italic()
						}
					case .failed:
						Text("Please tay again later")
					}
				}
			}
			.navigationTitle("Place details")
			.toolbar {
				Button("Save") {
					var newLocation = location
					newLocation.id = UUID()
					newLocation.name = name
					newLocation.description = description
					
					onSave(newLocation)
					dismiss()
				}
			}
			.task {
				await fetchNearbyPlaces()
			}
		}
	}
	
	init(location: Location, onSave: @escaping (Location) -> Void) {
		self.location = location
		self.onSave = onSave
		
		_name = State(initialValue: location.name)
		_description = State(initialValue: location.description)
	}
	
	private func fetchNearbyPlaces() async {
		let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
		
		guard let url = URL(string: urlString) else {
			loadingState = .failed
			print("Bad URL: \(urlString)")
			return
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			let items = try JSONDecoder().decode(Result.self, from: data)
			
			pages = items.query.pages.values.sorted()
			loadingState = .loaded
		} catch {
			loadingState = .failed
			print(error.localizedDescription)
		}
	}
}

#Preview {
	EditView(location: Location.example) { _ in }
}
