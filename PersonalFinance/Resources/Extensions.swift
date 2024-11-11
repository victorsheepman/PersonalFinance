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

extension Array where Element: Identifiable {
    func isLast(_ element: Element) -> Bool {
        guard let lastElement = self.last else { return false }
        return element.id == lastElement.id
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
