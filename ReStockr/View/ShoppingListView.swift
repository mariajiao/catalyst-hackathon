//
//  ShoppingListView.swift
//  ReStockr
//
//  Created by Maria Jiao on 2/21/25.
//

import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @Query var purchases: [PurchaseItem]

    var body: some View {
        NavigationView {
            if(purchases.filter { $0.isRunningLow }.isEmpty)
            {
                VStack(spacing: 16) {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    
                    Text("You are all clear. No shopping needed today!")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                }
                .padding()
            }
            else {
                List {
                    ForEach(purchases.filter { $0.isRunningLow }) { item in
                        HStack {
                            Button(action: {
                                togglePurchased(for: item)
                            }) {
                                Image(systemName: item.isPurchased ? "checkmark.square.fill" : "square")
                                    .foregroundColor(item.isPurchased ? .mint : .primary)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                    .strikethrough(item.isPurchased, color: .gray)
                                
                                Text("Qty: \(item.quantity)")
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .navigationTitle("Shopping List")
            }
        }
    }
    
    // Function to toggle the purchase status
    private func togglePurchased(for item: PurchaseItem) {
        if let index = purchases.firstIndex(where: { $0.id == item.id }) {
            purchases[index].isPurchased.toggle()
        }
    }
}

#Preview {
    ShoppingListView()
}
