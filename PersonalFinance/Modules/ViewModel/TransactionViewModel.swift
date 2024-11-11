//
//  TransactionViewModel.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import Foundation

class TransactionViewModel: ObservableObject, ViewModelProtocol {

    @Published var transactions: [Transaction] = []
    @Published var budgets: [Budget] = []
    

    private let dataSource: SwiftDataService
    
    init(dataSource: SwiftDataService = SwiftDataService.shared) {
        self.dataSource = dataSource
        fetchTransactions()
    }
    
    func addTransaction(to budget: Budget?, transaction: Transaction) -> Void {
        if transaction.type == .expense, let budget = budget {
            transactionToBudget(transaction, budget)
        }
        
        dataSource.append(transaction)
        transactions = []
        fetchTransactions()
    }
    
    private func transactionToBudget(_ transaction: Transaction, _ budget:Budget) -> Void{
        transaction.budget = budget
        budget.transactions?.append(transaction)
        budget.spent += transaction.amount
    }
   
    func fetchTransactions() {
        transactions = dataSource.fetch()
    }
    
    func fetchBudgets() {
        budgets = dataSource.fetch()
    }
}
