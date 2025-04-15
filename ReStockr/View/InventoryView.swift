//
//  InventoryView.swift
//  ReStockr
//
//  Created by Maria Jiao on 2/21/25.
//

import SwiftUI
import SwiftData

struct InventoryView: View {
    @Query var purchases: [PurchaseItem]  // Fetches stored purchases
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationView {
            List {
                ForEach(purchases) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("Category: \(item.category)")
                                .font(.subheadline)
                            Text("Running Low: \(item.isRunningLow ? "Yes" : "No")")
                                .foregroundColor(item.isRunningLow ? .red : .green)
                                .font(.caption)
                        }
                        Spacer()
                        Text("Qty: \(item.quantity)")
                    }
                }
                .onDelete(perform: deletePurchase) // Swipe to delete
            }
            .navigationTitle("Inventory")
            .toolbar {
                NavigationLink(destination: AddPurchaseView()) {
                    Text("Add Item")
                }
            }
        }
    }

    func deletePurchase(at offsets: IndexSet) {
        for index in offsets {
            context.delete(purchases[index])
        }
    }
}

#Preview {
    InventoryView()
}
