//
//  TransactionViewModel.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import Foundation


@Observable
class TransactionViewModel: ObservableObject {

    var transactions: [Transaction] = []
    var availableBudgets: [Budget] = []
    
    @ObservationIgnored
    private let dataSource: SwiftDataService
    
    init(dataSource: SwiftDataService = SwiftDataService.shared) {
        self.dataSource = dataSource
        getTransactions()
    }
    
    func addTransaction(to budget: Budget?, transaction: Transaction) -> Void {
        if transaction.type == .expense, let budget = budget {
            transactionToBudget(transaction, budget)
        }
        
        dataSource.append(transaction)
        transactions = []
        getTransactions()
    }
    
    func updateTransaction(transaction: Transaction, newTitle: String?, newAmount: Double?, newBudget: Budget?, newDate: Date?, newType: TransactionType?, newAccount: TransactionAccount?) {
        
        if let title = newTitle {
            transaction.title = title
        }
        
        if let amount = newAmount {
            transaction.amount = amount
        }
        
        
        if let budget = newBudget, transaction.budget != budget {
            removeTransactionFromBudget(transaction)
            transactionToBudget(transaction, budget)
        }
        
        if let date = newDate {
            transaction.date = date
        }
        
        if let type = newType {
            transaction.type = type
        }
        
        if transaction.type == .income{
            removeTransactionFromBudget(transaction)
        }
        
        if let account = newAccount {
            transaction.account = account
        }
        
        transactions = []
        getTransactions()
    }
    
    func removeTransaction(_ id: UUID) {
        let transactionToDelete: Transaction? = transactions.first { $0.id == id} ?? nil
        if let selectedTransaction = transactionToDelete {
            removeTransactionFromBudget(selectedTransaction)
            dataSource.remove(selectedTransaction)
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
    
    private func transactionToBudget(_ transaction: Transaction, _ budget:Budget) -> Void{
        transaction.budget = budget
        budget.transactions?.append(transaction)
        budget.spent += transaction.amount
    }
   
    func getTransactions() {
        transactions = dataSource.fetch()
    }
    
    func getAvailableBudgets() {
        availableBudgets = dataSource.fetch()
    }
}
