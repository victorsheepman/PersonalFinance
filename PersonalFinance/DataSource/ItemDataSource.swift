//
//  ItemDataSource.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import Foundation
import SwiftData

final class ItemDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ItemDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Budget.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendBudget(item: Budget) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchBudgets() -> [Budget] {
        do {
            return try modelContext.fetch(FetchDescriptor<Budget>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeBudget(item: Budget) {
        modelContext.delete(item)
        
    }
    
    
    ///TRANSACTION
    
    func appendTransaction(item: Transaction) {
    
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchTransaction() -> [Transaction] {
        do {
            return try modelContext.fetch(FetchDescriptor<Transaction>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
