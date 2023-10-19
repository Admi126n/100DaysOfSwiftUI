//
//  DetailView.swift
//  Friends
//
//  Created by Adam Tokarski on 18/10/2023.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Name") {
                        Text(user.wrappedName)
                            .foregroundStyle(user.isActive ? .primary : Color.red)
                    }
                    
                    if user.isActive {
                        Section("Details") {
                            Text("Registered at: \(user.wrappedRegistered.formatted(date: .abbreviated, time: .omitted))")
                            
                            Text("Age: \(user.age)")
                            
                            Text("Address: \(user.wrappedAddress)")
                        }
                        
                        Section("About") {
                            Text("\(user.wrappedAbout)")
                        }
                        
                        Section("Work") {
                            Text("Company: \(user.wrappedCompany)")
                            Text("Email: \(user.wrappedEmail)")
                        }
                    }
                    
                    Section("Tags") {
                        ForEach(user.tagsArray, id: \.self) { tag in
                            Text("\(tag)")
                        }
                    }
                    
                    Section("Friends list") {
                        ForEach(user.friendsArray, id: \.self) { friend in
                            Text("\(friend.wrappedName)")
                        }
                    }
                }
            }
            .navigationTitle(user.wrappedName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


//struct DetailView: View {
//    let user: User
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                List {
//                    Section("Name") {
//                        Text(user.name)
//                            .foregroundStyle(user.isActive ? .primary : Color.red)
//                    }
//                    
//                    if user.isActive {
//                        Section("Details") {
//                            Text("Registered at: \(user.registered.formatted(date: .abbreviated, time: .omitted))")
//                            
//                            Text("Age: \(user.age)")
//                            
//                            Text("Address: \(user.address)")
//                        }
//                        
//                        Section("About") {
//                            Text("\(user.about)")
//                        }
//                        
//                        Section("Work") {
//                            Text("Company: \(user.company)")
//                            Text("Email: \(user.email)")
//                        }
//                    }
//                    
//                    Section("Tags") {
//                        ForEach(user.tags, id: \.self) { tag in
//                            Text("\(tag)")
//                        }
//                    }
//                    
//                    Section("Friends list") {
//                        ForEach(user.friends) { friend in
//                            Text("\(friend.name)")
//                        }
//                    }
//                }
//            }
//            .navigationTitle(user.name)
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}

//#Preview {
//    DetailView(user: User(isActive: true, name: "Name", age: 21, company: "Company", email: "Email", address: "Address", about: "About", registered: Date.now, tags: ["Tag"], friends: [Friend(id: "Id", name: "Name")]))
//}
