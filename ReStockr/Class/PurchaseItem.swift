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
        Date() >= estimatedDepletionDate
    }
}
