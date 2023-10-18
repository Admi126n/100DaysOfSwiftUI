//
//  DetailView.swift
//  Friends
//
//  Created by Adam Tokarski on 18/10/2023.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Name") {
                        Text(user.name)
                            .foregroundStyle(user.isActive ? .primary : Color.red)
                    }
                    
                    
                    if user.isActive {
                        Section("Details") {
                            Text("Registered at: \(user.registered.formatted(date: .abbreviated, time: .omitted))")
                            
                            Text("Age: \(user.age)")
                            
                            Text("Address: \(user.address)")
                        }
                        
                        Section("About") {
                            Text("\(user.about)")
                        }
                        
                        Section("Work") {
                            Text("Company: \(user.company)")
                            Text("Email: \(user.email)")
                        }
                    }
                    
                    Section("Friends list") {
                        ForEach(user.friends) { friend in
                            Text("\(friend.name)")
                        }
                    }
                }
            }
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DetailView(user: User(isActive: true, name: "Name", age: 21, company: "Company", email: "Email", address: "Address", about: "About", registered: Date.now, tags: ["Tag"], friends: [Friend(id: "Id", name: "Name")]))
}
