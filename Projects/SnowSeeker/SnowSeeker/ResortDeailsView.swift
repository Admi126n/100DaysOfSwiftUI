//
//  ResortDeailsView.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 24/11/2023.
//

import SwiftUI

struct ResortDeailsView: View {
	let resort: Resort
	
	var size: String {
		switch resort.size {
		case 1:
			return "Small"
		case 2:
			return "Average"
		default:
			return "Large"
		}
	}
	
	var price: String {
		String(repeating: "$", count: resort.price)
	}
	
    var body: some View {
		Group {
			VStack {
				Text("Size")
					.font(.caption.bold())
				
				Text(size)
					.font(.title3)
			}
			
			VStack {
				Text("Price")
					.font(.caption.bold())
				
				Text(price)
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
	ResortDeailsView(of: Resort.example)
}
