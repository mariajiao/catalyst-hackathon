//
//  AddPurchaseView.swift
//  ReStockr
//
//  Created by Maria Jiao on 2/21/25.
//

import SwiftUI
import SwiftData

struct AddPurchaseView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var selectedCategory = ""
    @State private var quantity = ""
    @State private var usageDays = ""
    
    let options = ["Vegetables", "Protein", "Dairy", "Snacks", "Drinks", "Household Item", "Misc"]

    var body: some View {
        Form {
            Section(header: Text("Item Details")) {
                TextField("Item Name", text: $name)
                
                TextField("Category", text: $selectedCategory)
                    

                
                TextField("Quantity", text: $quantity)
                    .keyboardType(.numberPad)
                TextField("Usage Days", text: $usageDays)
                    .keyboardType(.numberPad)
            }

            Button(action: addPurchase) {
                Text("Save Item")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mint)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Add Purchase")
    }

    func addPurchase() {
        guard !name.isEmpty, selectedCategory != "",
              let qty = Int(quantity), let days = Int(usageDays) else {
            return  // Prevents saving if fields are empty or invalid
        }

        let newItem = PurchaseItem(
            name: name,
            category: selectedCategory, // Use selected category
            purchaseDate: Date(),
            estimatedUsageDays: days,
            quantity: qty,
            isPurchased: false
        )

        withAnimation {
            context.insert(newItem) // inserting into SwiftData
        }
        
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddPurchaseView()
            .modelContainer(for: PurchaseItem.self)
    }
}
