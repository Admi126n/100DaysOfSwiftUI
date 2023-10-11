//
//  ContentView.swift
//  Bookworm
//
//  Created by Adam Tokarski on 11/10/2023.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(
            LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom)
        )
        .foregroundStyle(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            
            Button("Add") {
                let firstNames = ["Ginny", "Hary", "Hermione", "Luna", "Ron"]
                let laseNames = ["Granger", "Lovegood", "Potter", "Weasly"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = laseNames.randomElement()!
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? moc.save()
            }
        }
    }
    
// 2
//    @AppStorage("notes") private var notes = ""
//    var body: some View {
//        NavigationStack {
//            TextEditor(text: $notes)
//                .navigationTitle("Notes")
//                .padding()
//        }
//    }
    
// 1
//    @State private var rememberMe = false
//    var body: some View {
//        VStack {
//            PushButton(title: "Rember me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
//    }
}

#Preview {
    ContentView()
}
