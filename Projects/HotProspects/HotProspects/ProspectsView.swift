//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Adam Tokarski on 09/11/2023.
//

import SwiftUI

struct ProspectsView: View {
	enum FilterType {
		case none
		case contacted
		case uncontacted
	}
	
	@EnvironmentObject var prospects: Prospects
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
				}
			}
			.navigationTitle(title)
			.toolbar {
				Button {
					let prospect = Prospect()
					prospect.name = "Paul Hudson"
					prospect.emailAddress = "paul@hackingwithswift.com"
					prospects.people.append(prospect)
				} label: {
					Label("Scan", systemImage: "qrcode.viewfinder")
				}
			}
		}
	}
}

#Preview {
	ProspectsView(filter: .none)
		.environmentObject(Prospects())
}
