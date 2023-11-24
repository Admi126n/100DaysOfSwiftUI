//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 24/11/2023.
//

import SwiftUI

struct SkiDetailsView: View {
	let resort: Resort
	
    var body: some View {
		Group {
			VStack {
				Text("Elevation")
					.font(.caption.bold())
				
				Text("\(resort.elevation)")
					.font(.title3)
			}
			
			VStack {
				Text("Snow")
					.font(.caption.bold())
				
				Text("\(resort.snowDepth)cm")
					.font(.title3)
			}
		}
		.frame(maxWidth: .infinity)
    }
	
	init(of resort: Resort) {
		self.resort = resort
	}
}

#Preview {
	SkiDetailsView(of: Resort.example)
}
