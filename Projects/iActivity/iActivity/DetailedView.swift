//
//  DetailedView.swift
//  iActivity
//
//  Created by Adam Tokarski on 05/10/2023.
//

import SwiftUI

struct DetailedView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var activities: Activities
    
    var activityItem: ActivityItem
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    Text(activityItem.title)
                }
                
                Section("Description") {
                    Text(activityItem.description)
                }
                
                Section("Activity counter:") {
                    HStack {
                        let times = activityItem.count == 1 ? "time" : "times"
                        Text("Activity done \(activityItem.count) \(times)")
                        
                        Spacer()
                        
                        Button {
                            activities.incrementCounter(for: activityItem)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                HStack {
                    Spacer()
                    Button("Delete", role: .destructive) {
                        activities.deleteActivity(activityItem)
                        dismiss()
                    }
                    Spacer()
                }
                
            }
            .navigationTitle("Detailed view")
        }
    }
}

#Preview {
    DetailedView(
        activities: Activities(),
        activityItem: ActivityItem(title: "Title", description: "Description")
    )
}
