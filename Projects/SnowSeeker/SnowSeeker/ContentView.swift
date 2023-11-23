//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Adam Tokarski on 23/11/2023.
//

import SwiftUI

struct User: Identifiable {
	var id = "Taylor Swift"
}

struct UserView: View {
	var body: some View {
		Group {
			Text("Name: Paul")
			Text("Country: England")
			Text("Pets: Luna and Arya")
		}
		.font(.title)
	}
}

struct ContentView: View {
	@State private var searchText = ""
	let allNames = ["Bob", "Paul", "Steve"]
	
	var filteredNames: [String] {
		if searchText.isEmpty {
			return allNames
		} else {
			return allNames.filter{ $0.localizedCaseInsensitiveContains(searchText) }
		}
	}
	
	var body: some View {
		NavigationStack {
			List(filteredNames, id: \.self) {
				Text($0)
			}
			.searchable(text: $searchText, prompt: "Look for something")
			.navigationTitle("Searching")
		}
	}
	
//	@State private var column: NavigationSplitViewVisibility = .all
//	var body: some View {
//		NavigationSplitView(columnVisibility: $column) {
//			Text("Primary")
//		} detail: {
//			Text("Secondary")
//		}
//		.navigationSplitViewStyle(.balanced)
//	}
	
//	@Environment(\.horizontalSizeClass) var sizeClass
//	var body: some View {
//		if sizeClass == .compact {
//			VStack(content: UserView.init)
//		} else {
//			HStack(content: UserView.init)
//		}
//	}
}

#Preview {
	ContentView()
}
