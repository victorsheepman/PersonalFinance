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
    
    @ObservationIgnored
    private let dataSource: ItemDataSource

    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
        getBudgets()
        getTransactions()
    }
   
   
    var budgets: [Budget] = []
    var transactions: [Transaction] = [] 
    

    // Mark:  Optomizar
    @MainActor
    func addBudget(category: BudgetCategory, max: Double, spent: Double, theme: BudgetTheme) {
        let newBudget = Budget(id: UUID(), category: category, max: max, spent: spent, theme: theme, transactions: [])
       insertBudget(budget: newBudget)
    }
    
   
    private func insertBudget(budget: Budget) {
        dataSource.append(budget)
        budgets = []
        getBudgets()
    }
    
    
    func deleteBudget(budget: Budget) {
        dataSource.remove(budget)
        budgets = []
        getBudgets()
    }
    
    @MainActor
    func updateBudget(budget: Budget, newCategory: BudgetCategory, newMax: Double, newSpent: Double, newTheme: BudgetTheme) {
        
        budget.category = newCategory
        budget.max = newMax
        budget.spent = newSpent
        budget.theme = newTheme
        
        budgets = []
        getBudgets()
    }
    
    @MainActor
    func addTransaction(to budget: Budget?, title: String, amount: Double, date: Date, type: TransactionType) {
        
        if type == .expense, let budget = budget {
            let transaction = Transaction(title: title, amount: amount, date: date, type: type, budget: budget)
            
            dataSource.append(transaction)
            budget.transactions?.append(transaction)
            
            budget.spent += amount
            
            
        } else if type == .income {
            
            let transaction = Transaction(title: title, amount: amount, date: date, type: type, budget: nil)
            
            dataSource.append(transaction)
        } else {
            print("Solo se pueden asociar transacciones de tipo 'expense' a un presupuesto.")
            return
        }
        
        
        budgets = []
        getBudgets()
        
        transactions = []
        getTransactions()
    }
    
    
    func getBudgets() {
        budgets = dataSource.fetch()
    }
    
    func getTransactions() {
        transactions = dataSource.fetch()
    }
    
    
       

    var totalMax: Double {
        budgets.reduce(0) { $0 + $1.max }
    }
    
    var totalSpent: Double {
        budgets.reduce(0) { $0 + $1.spent }
    }
}
