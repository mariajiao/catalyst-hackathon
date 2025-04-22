//
//  PurchaseItem.swift
//  ReStockr
//
//  Created by Maria Jiao on 2/21/25.
//


import SwiftData
import Foundation


@Model
class PurchaseItem {
    var name: String
    var category: String
    var purchaseDate: Date
    var estimatedUsageDays: Int
    var quantity: Int
    var isPurchased: Bool


    init(name: String, category: String, purchaseDate: Date, estimatedUsageDays: Int, quantity: Int, isPurchased: Bool) {
        self.name = name
        self.category = category
        self.purchaseDate = purchaseDate
        self.estimatedUsageDays = estimatedUsageDays
        self.quantity = quantity
        self.isPurchased = isPurchased
    }

    // Estimated depletion date calculation
    var estimatedDepletionDate: Date {
        Calendar.current.date(byAdding: .day, value: estimatedUsageDays, to: purchaseDate) ?? Date()
    }

    // Check if item is running low
    var isRunningLow: Bool {
        let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        return twoDaysFromNow >= estimatedDepletionDate
        
    }
    
    var runoutDays: Int {
        if((Calendar.current.dateComponents([.day], from: Date(), to: estimatedDepletionDate).day ?? 0) > 0)
        {
            return (Calendar.current.dateComponents([.day], from: Date(), to: estimatedDepletionDate).day ?? 0)
        }
        else {
            return 0
        }
            
    }
}


func exportToCSV(purchases: [PurchaseItem]) -> URL? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    let header = "name,category,purchaseDate,estimatedUsageDays,quantity,isPurchased\n"
    let rows = purchases.map { item in
        let date = formatter.string(from: item.purchaseDate)
        return "\"\(item.name)\",\"\(item.category)\",\(date),\(item.estimatedUsageDays),\(item.quantity),\(item.isPurchased)"
    }

    let csvString = header + rows.joined(separator: "\n")

    // Save to the app's Documents directory
    let fileName = "purchase_history.csv"
    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

    do {
        try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        print("success! CSV file saved at: \(fileURL.path)")
        return fileURL
    } catch {
        print("aw snap! failed to write CSV: \(error)")
        return nil
    }
}
