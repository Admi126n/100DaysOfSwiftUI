//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Adam Tokarski on 15/10/2023.
//

import SwiftUI

// \.self is based on hash value of struct/object. Used struct has to conform to Hashable
// hash calculated twice: first in first app run and then second after relaunching app can have different values

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
//        Button("Save") {
//            if moc.hasChanges {
//                try? moc.save()
//            }
//        }
    }
}

#Preview {
    ContentView()
}
