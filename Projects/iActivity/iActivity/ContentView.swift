//
//  ContentView.swift
//  iActivity
//
//  Created by Adam Tokarski on 05/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            List(activities.activities) { activity in
                NavigationLink {
                    DetailedView(activities: activities, activityItem: activity)
                } label: {
                    Text(activity.title)
                }
            }
            .navigationTitle("iActivity")
            .toolbar {
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showSheet) {
                AddView(activities: activities)
            }
        }
    }
}

#Preview {
    ContentView()
}
