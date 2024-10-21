//
//  Transaction.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import Foundation

enum TransactionCategory: String, CaseIterable {
    case general        = "Food"
    case entertainment  = "Entertainment"
    case bills          = "Bills"
    case diningOut      = "Dining Out"
    case personalCare   = "Personal Care"
       
    var icon: String {
        switch self {
        case .entertainment:
            return "film"
        case .bills:
            return "doc.text"
        case .diningOut:
            return "cart"
        case .personalCare:
            return "heart"
        case .general:
            return "lightbulb"
        }
    }
}


struct Transaction: Identifiable {
    let id = UUID()
    let sender: String
    let amount: Double
    let date: Date
    let category: TransactionCategory?
    
}
