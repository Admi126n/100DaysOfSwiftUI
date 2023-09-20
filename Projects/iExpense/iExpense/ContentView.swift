//
//  ContentView.swift
//  iExpense
//
//  Created by Adam Tokarski on 20/09/2023.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        VStack {
            Text("Hello, your name is \(user.firstName) \(user.lastName)")
            
            HStack {
                TextField("First name", text: $user.firstName)
                    .padding()
                
                TextField("Last name", text: $user.lastName)
                    .padding()
            }
            
            Button("Save user") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            .padding()
            
            Button("Load user") {
                let decoder = JSONDecoder()
                
                if let data = UserDefaults.standard.data(forKey: "UserData") {
                    do {
                        user = try decoder.decode(User.self, from: data)
                    } catch {
                        user = User(firstName: "Unknown", lastName: "Unknown")
                    }
                }
            }
            .padding()
            
            Button("Dismiss") {
                dismiss()
            }
            .padding()
        }
    }
}

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @AppStorage("number") private var currentNumber = 1
    
    @State private var showSheet = false
    @State private var numbers: [Int] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                .padding()
                
                Button("Show second screen") {
                    showSheet.toggle()
                }
                .padding()
            }
            .navigationTitle("onDelete")
            .toolbar {
                EditButton()
            }
        }
        .sheet(isPresented: $showSheet) {
            SecondView()
        }
    }
    
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
