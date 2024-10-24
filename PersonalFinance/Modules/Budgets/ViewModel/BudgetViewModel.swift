//
//  BudgetViewModel.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 23/10/24.
//

import Foundation
import SwiftData

@Observable
class BudgetViewModel: ObservableObject {
    
   

    let container = try! ModelContainer(for: Budget.self)
    
    @MainActor
    var modelContext: ModelContext {
        container.mainContext
    }
    
    var budgets: [Budget] = []
    
    @MainActor
    func getBudgets() {
        let fetchDescriptor = FetchDescriptor<Budget>()
        
        budgets = try! modelContext.fetch(fetchDescriptor)
        print(budgets)
    }
    
  

    @MainActor 
    func addBudget(category: BudgetCategory, max: Double, spent: Double, theme: BudgetTheme) {
        let newBudget = Budget(id: UUID(), category: category, max: max, spent: spent, theme: theme)
       insertBudget(budget: newBudget)
    }
    
    @MainActor
    private func insertBudget(budget: Budget) {
        modelContext.insert(budget)
        budgets = []
        getBudgets()
    }
    
    @MainActor
        func deleteBudget(budget: Budget) {
            modelContext.delete(budget)
            budgets = []
            getBudgets()
        }

    var totalMax: Double {
        budgets.reduce(0) { $0 + $1.max }
    }
    
    var totalSpent: Double {
        budgets.reduce(0) { $0 + $1.spent }
    }
}
