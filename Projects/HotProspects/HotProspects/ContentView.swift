//
//  ContentView.swift
//  HotProspects
//
//  Created by Adam Tokarski on 06/11/2023.
//

import SwiftUI

@MainActor class User: ObservableObject {
	@Published var name = "Taylor Swift"
}

struct EditView: View {
	@EnvironmentObject var user: User
	
	var body: some View {
		TextField("Name", text: $user.name)
	}
}

struct DisplayView: View {
	@EnvironmentObject var user: User
	
	var body: some View {
		Text(user.name)
	}
}


struct ContentView: View {
	@State private var selectedTab = "One"
	
	var body: some View {
		TabView(selection: $selectedTab) {
			Text("Tab 1")
				.onTapGesture {
					selectedTab = "Two"
				}
				.tabItem {
					Label("One", systemImage: "star")
				}
				.tag("One")
			
			Text("Tab 2")
				.tabItem {
					Label("Two", systemImage: "circle")
				}
				.tag("Two")
		}
	}
	
// 1
//	@StateObject var user = User()
//    var body: some View {
//        VStack {
//			EditView()
//			
//			DisplayView()
//        }
//		.environmentObject(user)
//    }
}

#Preview {
    ContentView()
}
