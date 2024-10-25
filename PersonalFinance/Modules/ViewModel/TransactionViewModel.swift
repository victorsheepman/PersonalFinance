//
//  TransactionViewModel.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import Foundation


@Observable
class TransactionViewModel: ObservableObject {
    
    @ObservationIgnored
    private let dataSource: ItemDataSource

    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
        getTransactions()
    }
    
    var transactions: [Transaction] = []
    var availableBudgets: [Budget] = []
    
    
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
        
        transactions = []
        getTransactions()
    }
    
    
   
    func getTransactions() {
        transactions = dataSource.fetch()
    }
    
    func getAvailableBudgets() {
        availableBudgets = dataSource.fetch()
    }
    
    
}
