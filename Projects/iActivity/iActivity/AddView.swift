//
//  AddView.swift
//  iActivity
//
//  Created by Adam Tokarski on 05/10/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activities: Activities
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Activity name", text: $title)
                
                TextField("Activity description", text: $description)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Add") {
                    if title.isEmpty {
                        alertTitle = "Title cannot be empty"
                        showAlert = true
                        return
                    }
                    
                    if description.isEmpty {
                        alertTitle = "Description cannot be empty"
                        showAlert = true
                        return
                    }
                    
                    let newActivity = ActivityItem(
                        title: title,
                        description: description
                    )
                    
                    activities.addActivity(newActivity)
                    dismiss()
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") { }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
