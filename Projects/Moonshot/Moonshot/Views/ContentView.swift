//
//  ContentView.swift
//  Moonshot
//
//  Created by Adam Tokarski on 23/09/2023.
//

import SwiftUI

struct ContentView: View {
	let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
	let missions: [Mission] = Bundle.main.decode("missions.json")
	
	@State private var showList = false
	
	var body: some View {
		NavigationStack {
			Group {
				if showList {
					ListLayout(astronauts: astronauts, missions: missions)
				} else {
					GridLayout(astronauts: astronauts, missions: missions)
				}
			}
			.navigationTitle("Moonshot")
			.background(.darkBackground)
			.preferredColorScheme(.dark)
			.toolbar {
				Button {
					withAnimation {
						showList.toggle()
					}
				} label: {
					if showList {
						Image(systemName: "square.grid.2x2")
					} else {
						Image(systemName: "list.bullet")
					}
				}
				.accessibilityLabel("Switch view style")
			}
		}
	}
}

#Preview {
	ContentView()
}

// MARK: - Layout Views

fileprivate struct GridLayout: View {
	let astronauts: [String: Astronaut]
	let missions: [Mission]
	
	let columns = [
		GridItem(.adaptive(minimum: 150))
	]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns) {
				ForEach(missions) { mission in
					NavigationLink {
						MissionView(mission: mission, astronauts: astronauts)
					} label: {
						VStack {
							Image(mission.imageName)
								.resizable()
								.scaledToFit()
								.frame(width: 100, height: 100)
								.padding()
							
							VStack {
								Text(mission.displayName)
									.font(.headline)
									.foregroundStyle(.white)
								
								BottomText(mission.formattedLaunchDate)
							}
							.padding(.vertical)
							.frame(maxWidth: .infinity)
							.background(.lightBackground)
						}
						.clipShape(RoundedRectangle(cornerRadius: 10))
						.overlay(
							RoundedRectangle(cornerRadius: 10)
								.stroke(.lightBackground)
						)
						.accessibilityElement()
						.accessibilityLabel(mission.displayName)
						.accessibilityHint(mission.formattedLaunchDate)
						.accessibilityAddTraits(.isButton)
					}
				}
			}
			.padding([.horizontal, .bottom])
		}
	}
}

fileprivate struct ListLayout: View {
	let astronauts: [String: Astronaut]
	let missions: [Mission]
	
	var body: some View {
		List(missions) { mission in
			HStack(spacing: 20) {
				NavigationLink {
					MissionView(mission: mission, astronauts: astronauts)
				} label: {
					Image(mission.imageName)
						.resizable()
						.scaledToFit()
						.frame(width: 80, height: 80)
					
					VStack(alignment: .leading) {
						Text(mission.displayName)
							.font(.headline)
							.foregroundStyle(.white)
						
						BottomText(mission.formattedLaunchDate)
					}
				}
				.accessibilityElement()
				.accessibilityLabel(mission.displayName)
				.accessibilityHint(mission.formattedLaunchDate)
				.accessibilityAddTraits(.isButton)
			}
			.listRowBackground(Color.darkBackground)
		}
		.listStyle(.plain)
	}
}
