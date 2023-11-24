//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 24/11/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
		VStack {
			Text("Welcome to SnowSeeker!")
				.font(.largeTitle)
			
			Text("Please select a resort from the left hand menu.")
				.foregroundStyle(.secondary)
		}
    }
}

#Preview {
    WelcomeView()
}
