//
//  ContentView.swift
//  Friends
//
//  Created by Adam Tokarski on 18/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                List(users) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        Text("\(user.name)")
                    }
                }
                
                Text("\(users.count)")
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
    }
}

#Preview {
    ContentView()
}
