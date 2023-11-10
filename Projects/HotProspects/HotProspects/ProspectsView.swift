//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Adam Tokarski on 09/11/2023.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {
	enum FilterType {
		case none
		case contacted
		case uncontacted
	}
	
	@EnvironmentObject var prospects: Prospects
	@State private var showingScanner = false
	
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
				ForEach(filteredProspects) { prospect in
					VStack(alignment: .leading) {
						Text(prospect.name)
							.font(.headline)
						
						Text(prospect.emailAddress)
							.foregroundStyle(.secondary)
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
						}
					}
				}
			}
			.navigationTitle(title)
			.toolbar {
				Button {
					showingScanner = true
				} label: {
					Label("Scan", systemImage: "qrcode.viewfinder")
				}
			}
			.sheet(isPresented: $showingScanner) {
				CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
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
			
			prospects.people.append(person)
		case .failure(let failure):
			print(failure.localizedDescription)
		}
	}
}

#Preview {
	ProspectsView(filter: .none)
		.environmentObject(Prospects())
}
