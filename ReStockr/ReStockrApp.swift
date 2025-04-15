//
//  ReStockrApp.swift
//  ReStockr
//
//  Created by Maria Jiao on 2/21/25.
//
import SwiftUI
import SwiftData

@main
struct ReStockrApp: App {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([PurchaseItem.self]) //tells SwiftData to store PurchaseItem
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) //tells where to store
        do {
            return try ModelContainer(for: schema, configurations: [config]) //database
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}

