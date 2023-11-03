//
//  MissionView.swift
//  Moonshot
//
//  Created by Adam Tokarski on 25/09/2023.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
						.accessibilityLabel(mission.displayName)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        CustomDivider()
							.accessibilityHidden(true)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Mission  Highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                            
                            BottomText(mission.formattedLaunchDate)
                        }
                        
                        Text(mission.description)
                        
                        CustomDivider()
							.accessibilityHidden(true)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewMembersScrollView(crew)
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}

// MARK: - Custom Views

fileprivate struct CrewMembersScrollView: View {
    let crew: [MissionView.CrewMember]
    
    init(_ crew: [MissionView.CrewMember]) {
        self.crew = crew
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(crew, id: \.role) {
                    CrewMemberView($0)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

fileprivate struct CrewMemberView: View {
    let member: MissionView.CrewMember
    
    init(_ member: MissionView.CrewMember) {
        self.member = member
    }
    
    var body: some View {
        NavigationLink {
            AstronautView(astronaut: member.astronaut)
        } label: {
            HStack {
                Image(member.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.white, lineWidth: 1)
                    }
					.accessibilityHidden(true)
                
                VStack(alignment: .leading) {
                    Text(member.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    BottomText(member.role)
                }
            }
            .padding(.horizontal)
        }
        
    }
}
