//
//  DetailView.swift
//  Meetup
//
//  Created by Adam Tokarski on 04/11/2023.
//

import SwiftUI

struct DetailView: View {
	var photoData: PhotoData
	
    var body: some View {
		NavigationStack {
			VStack {
				Image(uiImage: photoData.image)
					.resizable()
					.scaledToFit()
				
				Text(photoData.description)
				
				Spacer()
			}
		}
    }
	
	init(of photoData: PhotoData) {
		self.photoData = photoData
	}
}
