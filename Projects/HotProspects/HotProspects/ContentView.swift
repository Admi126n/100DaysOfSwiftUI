//
//  ContentView.swift
//  HotProspects
//
//  Created by Adam Tokarski on 06/11/2023.
//

import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
	let possibleNumbers = Array(1...60)
	
	var results: String {
		let selected = possibleNumbers.random(7).sorted()
		let strings = selected.map(String.init)
		
		return strings.joined(separator: ", ")
	}
	
	var body: some View {
		Text(results)
	}
	
	
// 3
//	var body: some View {
//		VStack {
//			Button("Request permission") {
//				UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//					if success {
//						print("Done")
//					} else if let error = error {
//						print(error.localizedDescription)
//					}
//				}
//			}
//			.padding()
//			
//			Button("Schedule notification") {
//				let content = UNMutableNotificationContent()
//				content.title = "Feed the dogs"
//				content.subtitle = "They look hungry"
//				content.sound = UNNotificationSound.default
//				
//				let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//				
//				let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//				
//				UNUserNotificationCenter.current().add(request)
//			}
//			.padding()
//		}
//	}
	
	
// 2
//	var body: some View {
//		List {
//			Text("Taylor Swift")
//				.swipeActions {
//					Button(role: .destructive) {
//						print("Deleting")
//					} label: {
//						Label("Delete", systemImage: "minus.circle")
//					}
//				}
//				.swipeActions {
//					Button {
//						print("Done")
//					} label: {
//						Label("Done", systemImage: "checkmark")
//					}
//					.tint(.green)
//				}
//				.swipeActions(edge: .leading, allowsFullSwipe: false) {
//					Button {
//						print("Pinning")
//					} label: {
//						Label("Pin", systemImage: "pin")
//					}
//					.tint(.orange)
//				}
//		}
//	}
	
	
// 1
//	@State private var backgroundColor: Color = .red
//	var body: some View {
//		VStack {
//			Text("Hello, world")
//				.padding()
//				.background(backgroundColor)
//			
//			Text("Choose color")
//				.padding()
//				.contextMenu {
//					Button(role: .destructive) {
//						backgroundColor = .red
//					} label: {
//						Label("Red", systemImage: "checkmark.circle.fill")
//					}
//					
//					Button("Green") {
//						backgroundColor = .green
//					}
//					
//					Button("Blue") {
//						backgroundColor = .blue
//					}
//				}
//		}
//	}
}

#Preview {
	ContentView()
}
