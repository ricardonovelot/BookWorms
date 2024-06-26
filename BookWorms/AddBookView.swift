//
//  BookView.swift
//  BookWorms
//
//  Created by Ricardo on 14/03/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    var hasValidData : Bool {
        let fields = [title,author]
        return fields.allSatisfy({ $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
    }
    
    let genres = ["Fantasy","Horror","Kids","Mystery","Romance"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review"){
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section{
                    Button("Save"){
                        //add the Book
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(hasValidData)
                }
            }
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
           AddBookView()
                .modelContainer(for: Book.self)
       }
}
