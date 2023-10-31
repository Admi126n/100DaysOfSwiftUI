//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Adam Tokarski on 31/10/2023.
//

import SwiftUI

extension EditView {
	enum LoadingState {
		case loading
		case loaded
		case failed
	}
	
	@MainActor class EditViewModel: ObservableObject {
		@Published private(set) var location: Location
		
		@Published var name: String
		@Published var description: String
		
		@Published private(set) var loadingState: LoadingState = .loading
		@Published private(set) var pages: [Page] = []
		
		init(location: Location) {
			self.location = location
			self.name = location.name
			self.description = location.description
		}
		
		func fetchNearbyPlaces() async {
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
		
		func editLocation() -> Location {
			var newLocation = location
			newLocation.id = UUID()
			newLocation.name = name
			newLocation.description = description
			
			return newLocation
		}
	}
}
