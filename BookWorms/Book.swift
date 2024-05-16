//
//  Book.swift
//  BookWorms
//
//  Created by Ricardo on 14/03/24.
//

import Foundation
import SwiftData
import UIKit
import SwiftUI

@Model
class Book{
    
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date = Date.now
    var validData: Bool {
        if title.isEmpty || author.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
    

}
