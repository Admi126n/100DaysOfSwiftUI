//
//  AddBookView.swift
//  Bookworm
//
//  Created by Adam Tokarski on 12/10/2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let geners = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thiller"]
    
    var formIsValid: Bool {
        return !(genre.isEmpty || title.isEmpty)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(geners, id: \.self) { Text($0) }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating, offImage: Image(systemName: "star"))
                }
                
                Section {
                    Button("Save") { 
                        addBook()
                    }
                    .disabled(!formIsValid)
                }
            }
            .navigationTitle("Add book")
        }
    }
    
    private func addBook() {
        if author.isEmpty {
            author = "Unknown author"
        }
        
        let newBook = Book(context: moc)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre = genre
        newBook.review = review
        newBook.date = Date.now
        
        try? moc.save()
        dismiss()
    }
}

#Preview {
    AddBookView()
}
