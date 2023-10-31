//
//  EditView.swift
//  BucketList
//
//  Created by Adam Tokarski on 28/10/2023.
//

import SwiftUI

struct EditView: View {
	@Environment(\.dismiss) var dismiss
	@StateObject private var editViewModel: EditViewModel
	var onSave: (Location) -> Void
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Place name", text: $editViewModel.name)
					TextField("Place descriprion", text: $editViewModel.description)
				}
				
				Section("Nearby") {
					switch editViewModel.loadingState {
					case .loading:
						Text("Loading...")
					case .loaded:
						ForEach(editViewModel.pages, id: \.pageid) { page in
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
					let newLocation = editViewModel.editLocation()
					onSave(newLocation)
					dismiss()
				}
			}
			.task {
				await editViewModel.fetchNearbyPlaces()
			}
		}
	}
	
	init(location: Location, onSave: @escaping (Location) -> Void) {
		self.onSave = onSave
		_editViewModel = StateObject(wrappedValue: EditViewModel(location: location))
	}
}

#Preview {
	EditView(location: Location.example) { _ in }
}
