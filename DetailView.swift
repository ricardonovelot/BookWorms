//
//  DetailView.swift
//  BookWorms
//
//  Created by Ricardo on 15/03/24.
//

import SwiftData
import SwiftUI
import Glur

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var formattedDate : String {
        book.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading) {
                    Image(book.genre)
                        .resizable()
                        .scaledToFit()
                        .glur(radius: 30.0, // The total radius of the blur effect when fully applied.
                              offset: 0.5, // The distance from the view's edge to where the effect begins, relative to the view's size.
                              interpolation: 0.5, // The distance from the offset to where the effect is fully applied, relative to the view's size.
                              direction: .down // The direction in which the effect is applied.
                        )
                        .cornerRadius(12)
                        .shadow(color: Color(UIImage(named:book.genre)?.averageColor ?? .clear), radius: 2)
                     
                    VStack(alignment: .leading){
                        Text(book.title)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        Text(book.author.isEmpty ? "Unknown Author" : book.author)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .shadow(radius: 12)
                    .padding([.top, .leading, .trailing], 16)
                    .padding(.bottom, 12)
                }
                
                VStack (alignment: .leading, spacing: 8){
                    Text("Review")
                        .font(.headline) // Label the section for clarity
                    .padding(.top)
                    if !book.review.isEmpty {
                        Text(book.review)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                    
                    RatingView(rating: .constant(book.rating))
                        .scaledToFit()
                    
                    Text("Reviewed on \(formattedDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top,8)
                    
                }
            }
            .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book",isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar{
            Button("Delete this book", systemImage: "trash"){
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Harry Potter", author: "", genre: "Fantasy", review: "", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
