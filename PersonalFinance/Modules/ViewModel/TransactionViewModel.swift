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
    func addTransaction(to budget: Budget?, transaction: Transaction) -> Void {
        if transaction.type == .expense, let budget = budget {
            transaction.budget = budget
            budget.transactions?.append(transaction)
            budget.spent += transaction.amount
        }
            
        dataSource.append(transaction)
        transactions = []
        getTransactions()
    }
    
    
    func removeTransaction(at indexSet: IndexSet) -> Void {
        for i in indexSet {
            let transactionToDelete = transactions[i]
            removeTransactionFromBudget(transactionToDelete)
            dataSource.remove(transactionToDelete)
        }
    }
    
    private func removeTransactionFromBudget(_ transaction: Transaction) -> Void {
        guard let budget = transaction.budget else {
            return
        }
        
        if let index = budget.transactions?.firstIndex(where: { $0.id == transaction.id }) {
            budget.transactions?.remove(at: index)
            
            budget.spent -= transaction.amount
        }
    
    }
   
    func getTransactions() {
        transactions = dataSource.fetch()
    }
    
    func getAvailableBudgets() {
        availableBudgets = dataSource.fetch()
    }
}
