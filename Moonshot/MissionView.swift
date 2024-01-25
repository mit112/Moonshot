//
//  MissionView.swift
//  Moonshot
//
//  Created by Mit Sheth on 1/25/24.
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
        ScrollView {
            VStack {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                Text(mission.formattedLaunchDate)
                    .padding(.top, 15)
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
//                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                CrewView(crew: crew)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(crew, id: \.role) { crew in
//                            NavigationLink {
//                                AstronautView(astronaut: crew.astronaut)
//                            } label: {
//                                HStack {
//                                    Image(crew.astronaut.id)
//                                        .resizable()
//                                        .frame(width: 104, height: 72)
//                                        .clipShape(Capsule())
//                                        .overlay(
//                                            Capsule()
//                                                .strokeBorder(.white, lineWidth: 1)
//                                        )
//                                    VStack(alignment: .leading) {
//                                        Text(crew.astronaut.name)
//                                            .foregroundStyle(.white)
//                                            .font(.headline)
//                                        
//                                        Text(crew.role)
//                                            .foregroundStyle(.white.opacity(0.5 ))
//                                        
//                                    }
//                                }
//                                .padding()
//                            }
//                        }
//                    }
//                    
//                }
            }
//            .padding(.vertical)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission: Mission, astronaut: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronaut[member.name] {
                return CrewMember(role: member.name, astronaut: astronaut)
            } else {
                fatalError("Could not find \(member.name)")
            }
        }
        
    }
}


#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: mission[1], astronaut: astronaut)
        .preferredColorScheme(.dark)
}
