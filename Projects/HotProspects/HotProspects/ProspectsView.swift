//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Adam Tokarski on 09/11/2023.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
	private enum SortingType {
		case name
		case date
	}
	
	enum FilterType {
		case none
		case contacted
		case uncontacted
	}
	
	@EnvironmentObject var prospects: Prospects
	@State private var showingScanner = false
	@State private var showingDialog = false
	@State private var sortingType: SortingType = .name
	
	let filter: FilterType
	
	var title: String {
		switch filter {
		case .none:
			return "Everyone"
		case .contacted:
			return "Contacted people"
		case .uncontacted:
			return "Uncontacted people"
		}
	}
	
	var filteredProspects: [Prospect] {
		switch filter {
		case .none:
			return prospects.people
		case .contacted:
			return prospects.people.filter { $0.isContacted }
		case .uncontacted:
			return prospects.people.filter { !$0.isContacted }
		}
	}
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(filteredProspects.sorted(by: sorting)) { prospect in
					HStack {
						if filter == .none {
							Image(systemName: prospect.isContacted ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
								.font(.title)
						}
						
						VStack(alignment: .leading) {
							Text(prospect.name)
								.font(.headline)
							
							Text(prospect.emailAddress)
								.foregroundStyle(.secondary)
						}
					}
					.swipeActions {
						if prospect.isContacted {
							Button {
								prospects.toggle(prospect)
							} label: {
								Label("Mark uncontacted", systemImage: "person.crop.circle.badge.xmark")
							}
							.tint(.blue)
						} else {
							Button {
								prospects.toggle(prospect)
							} label: {
								Label("Mark contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
							}
							.tint(.green)
							
							Button {
								addNotification(for: prospect)
							} label: {
								Label("Remind me", systemImage: "bell")
							}
							.tint(.orange)
						}
					}
				}
			}
			.navigationTitle(title)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						showingScanner = true
					} label: {
						Label("Scan", systemImage: "qrcode.viewfinder")
					}
				}
				
				ToolbarItem(placement: .topBarLeading) {
					Button {
						showingDialog = true
					} label: {
						Label("Sort", systemImage: "arrow.up.arrow.down")
					}
				}
			}
			.sheet(isPresented: $showingScanner) {
				CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
			}
			.confirmationDialog("Sort by", isPresented: $showingDialog) {
				Button("Name") { sortingType = .name }
				Button("Date") { sortingType = .date }
			}
		}
	}
	
	private func handleScan(result: Result<ScanResult, ScanError>) {
		showingScanner = false
		
		switch result {
		case .success(let success):
			let details = success.string.components(separatedBy: "\n")
			guard details.count == 2 else { return }
			
			let person = Prospect()
			person.name = details[0]
			person.emailAddress = details[1]
			
			prospects.add(person)
		case .failure(let failure):
			print(failure.localizedDescription)
		}
	}
	
	private func addNotification(for prospect: Prospect) {
		let center = UNUserNotificationCenter.current()
		
		let addRequest = {
			let content = UNMutableNotificationContent()
			content.title = "Contact \(prospect.name)"
			content.subtitle = prospect.emailAddress
			content.sound = .default
			
			var dateComponents = DateComponents()
			dateComponents.hour = 9
//			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
			
			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			center.add(request)
		}
		
		center.getNotificationSettings { settings in
			if settings.authorizationStatus == .authorized {
				addRequest()
			} else {
				center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						addRequest()
					} else {
						print("No permission")
					}
				}
			}
		}
	}
	
	private func sorting(_ lhs: Prospect, _ rhs: Prospect) -> Bool {
		switch sortingType {
		case .name:
			return lhs.name < rhs.name
		case .date:
			return lhs.addedDate < rhs.addedDate
		}
	}
}

#Preview {
	ProspectsView(filter: .none)
		.environmentObject(Prospects())
}
