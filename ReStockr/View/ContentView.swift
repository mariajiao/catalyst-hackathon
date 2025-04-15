//
//  ContentView.swift
//  ReStockr
//
//  Created by Maria Jiao on 2/21/25.
//

import SwiftUI
import SwiftData

#Preview {
    ContentView()
}
struct ContentView: View {
    var body: some View {
        TabView {
            InventoryView()
                .tabItem {
                    Label("Inventory", systemImage: "cart")
                }
            
            ShoppingListView()
                .tabItem {
                    Label("Shopping List", systemImage: "list.bullet")
                }
        }
    }
}


