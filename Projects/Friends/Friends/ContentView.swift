//
//  ContentView.swift
//  Friends
//
//  Created by Adam Tokarski on 18/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                List(cachedUsers, id: \.self) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        Text("\(user.wrappedName)")
                    }
                }
            }
            .navigationTitle("Friends")
            .onAppear {
                Task {
                    if users.isEmpty {
                        await getUsersList()
                    }
                }
            }
        }
    }
    
    private func getUsersList() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            print("Cannot fetch data")
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let decodedData = try? decoder.decode([User].self, from: data) else {
            print("Cannot decode data")
            return
        }
        
        users = decodedData
        
        await MainActor.run {
            addUsersToMoc()
        }
    }
    
    private func addUsersToMoc() {
        let names = cachedUsers.map { user in
            user.wrappedName
        }
        
        for user in users {
            guard !names.contains(user.name) else { continue }
            
            let cachedUser = CachedUser(context: moc)
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.isActive = user.isActive
            cachedUser.about = user.about
            cachedUser.address = user.address
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.name = friend.name
                cachedFriend.origin = cachedUser
            }
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
}

#Preview {
    ContentView()
}
