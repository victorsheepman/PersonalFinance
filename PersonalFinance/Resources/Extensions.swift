//
//  Extensions.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import Foundation
import SwiftData

extension Date {
    // Función para formatear la fecha en el formato deseado
    func formattedAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy" // Formato deseado: "19 Aug 2024"
        return formatter.string(from: self)
    }
}

extension Transaction {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Transaction.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(Transaction(title: "Test-1", amount: 20, date: .now, type: .expense, account: .basic))
        container.mainContext.insert(Transaction(title: "Test-2", amount: 20, date: .now, type: .expense, account: .person))
        return container
    }
}


extension Budget {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(Budget( category: .bills, max: 100.0 , spent: 0.0, theme: .cyan, transactions: []))
        return container
    }
}
