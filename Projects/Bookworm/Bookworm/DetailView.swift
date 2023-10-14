//
//  DetailView.swift
//  Bookworm
//
//  Created by Adam Tokarski on 13/10/2023.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "Fantasy")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
                .padding()
            
            Text("Revieved on: \((book.date ?? Date.now).formatted(date: .abbreviated, time: .omitted))")
                .font(.footnote)
            
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    private func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}
