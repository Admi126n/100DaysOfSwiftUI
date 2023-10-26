//
//  ContentView.swift
//  BucketList
//
//  Created by Adam Tokarski on 26/10/2023.
//

import SwiftUI

struct User: Identifiable, Comparable {
	let id = UUID()
	let firstName: String
	let lastName: String
	
	static func < (lhs: User, rhs: User) -> Bool {
		lhs.lastName < rhs.lastName
	}
}

enum LoadingState {
	case loading
	case success
	case failed
}

struct LoadingView: View {
	var body: some View {
		Text("Loading...")
	}
}

struct SuccessView: View {
	var body: some View {
		Text("Succes!")
	}
}

struct FailedView: View {
	var body: some View {
		Text("Failed.")
	}
}

struct ContentView: View {
	var loadingState = LoadingState.loading
	
	var body: some View {
		switch loadingState {
		case .loading:
			LoadingView()
		case .success:
			SuccessView()
		case .failed:
			FailedView()
		}
	}
	
// 2
//	var body: some View {
//		Text("Hello, World!")
//			.onTapGesture {
//				let str = ""
//				let url = getDocumentsDirectory().appendingPathComponent("message.txt")
//				
//				do {
//					try str.write(to: url, atomically: true, encoding: .utf8)
//
//					let input: String = FileManager.default.decode("message.txt")
//					print(input)
//					
//				} catch {
//					print(error.localizedDescription)
//				}
//			}
//	}
//	
//	private func getDocumentsDirectory() -> URL {
//		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//		return paths[0]
//	}
	
// 1
//	let users = [
//		User(firstName: "Jan", lastName: "Kowalski"),
//		User(firstName: "Spejson", lastName: "Puchacki"),
//		User(firstName: "Bob", lastName: "Budowniczy")
//	].sorted()
//    var body: some View {
//		List(users) { user in
//			Text("\(user.firstName) \(user.lastName)")
//		}
//    }
}

#Preview {
    ContentView()
}
