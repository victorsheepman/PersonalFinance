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
   
    var budgets: [Budget] = []
    var transactions: [Transaction] = [] 
    
    @MainActor
    var modelContext: ModelContext {
        container.mainContext
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
            
            modelContext.insert(transaction)
            budget.transactions?.append(transaction)
            
            budget.spent += amount
            
            
        } else if type == .income {
            
            let transaction = Transaction(title: title, amount: amount, date: date, type: type, budget: nil)
            
            modelContext.insert(transaction)
        } else {
            print("Solo se pueden asociar transacciones de tipo 'expense' a un presupuesto.")
            return
        }
        
        
        budgets = []
        getBudgets()
        
        transactions = []
        getTransactions()
    }
    
    @MainActor
    func getBudgets() {
        let fetchDescriptor = FetchDescriptor<Budget>()
        
        do {
            budgets = try modelContext.fetch(fetchDescriptor)
            print(budgets)
        } catch {
            print("Error fetching budgets: \(error.localizedDescription)")
        }
    }
    @MainActor
    func getTransactions() {
        let fetchDescriptor = FetchDescriptor<Transaction>()
        
        do {
            transactions = try modelContext.fetch(fetchDescriptor)
            print(transactions)
        } catch {
            print("Error fetching transactions: \(error.localizedDescription)")
        }
    }
    
    
       

    var totalMax: Double {
        budgets.reduce(0) { $0 + $1.max }
    }
    
    var totalSpent: Double {
        budgets.reduce(0) { $0 + $1.spent }
    }
}
