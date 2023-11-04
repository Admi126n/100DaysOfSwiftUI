//
//  PhotoDescription.swift
//  Meetup
//
//  Created by Adam Tokarski on 04/11/2023.
//

import SwiftUI

struct PhotoDescription: View {
	@Environment(\.dismiss) var dismiss
	@State var name: String = ""
	let image: UIImage
	let onSave: (String) -> Void
	
    var body: some View {
		NavigationStack {
			VStack {
				Image(uiImage: image)
					   .resizable()
					   .scaledToFit()
				
				Form {
					TextField("Photo description", text: $name)
				}
				.toolbar {
					Button("Save") {
						onSave(name)
						dismiss()
					}
				}
			}
		}
    }
}
