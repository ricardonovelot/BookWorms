//
//  BookWormsApp.swift
//  BookWorms
//
//  Created by Ricardo on 14/03/24.
//

import SwiftUI
import SwiftData

@main
struct BookWormsApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
