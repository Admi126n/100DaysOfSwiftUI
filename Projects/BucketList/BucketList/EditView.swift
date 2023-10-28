//
//  EditView.swift
//  BucketList
//
//  Created by Adam Tokarski on 28/10/2023.
//

import SwiftUI

struct EditView: View {
	@Environment(\.dismiss) var dismiss
	var location: Location
	var onSave: (Location) -> Void
	
	@State private var name: String
	@State private var description: String
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Place name", text: $name)
					TextField("Place descriprion", text: $description)
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
		}
    }
	
	init(location: Location, onSave: @escaping (Location) -> Void) {
		self.location = location
		self.onSave = onSave
		
		_name = State(initialValue: location.name)
		_description = State(initialValue: location.description)
	}
}

#Preview {
	EditView(location: Location.example) { _ in }
}
