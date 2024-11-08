//
//  BudgetViewModel.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 23/10/24.
//

import Foundation



class BudgetViewModel: ObservableObject, ViewModelProtocol {
    
    
    @Published var budgets: [Budget] = []
    
    private let dataSource: SwiftDataService

    init(dataSource: SwiftDataService = SwiftDataService.shared) {
        self.dataSource = dataSource
        fetchBudgets()
    }
    
    func addBudget(category: BudgetCategory, max: Double, spent: Double, theme: BudgetTheme) {
        let newBudget = Budget(id: UUID(), category: category, max: max, spent: spent, theme: theme, transactions: [])
       insertBudget(budget: newBudget)
    }
    
    func deleteBudget(budget: Budget) {
        dataSource.remove(budget)
        budgets = []
        fetchBudgets()
    }
    
    func updateBudget(budget: Budget, newCategory: BudgetCategory, newMax: Double, newSpent: Double, newTheme: BudgetTheme) {
        
        budget.category = newCategory
        budget.max = newMax
        budget.spent = newSpent
        budget.theme = newTheme
        
        budgets = []
        fetchBudgets()
    }
    
    func fetchBudgets() {
        budgets = dataSource.fetch()
    }
    
    private func insertBudget(budget: Budget) {
        dataSource.append(budget)
        budgets = []
        fetchBudgets()
    }

}
