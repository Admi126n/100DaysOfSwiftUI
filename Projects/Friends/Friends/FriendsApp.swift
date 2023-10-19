//
//  FriendsApp.swift
//  Friends
//
//  Created by Adam Tokarski on 18/10/2023.
//

import SwiftUI

@main
struct FriendsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
