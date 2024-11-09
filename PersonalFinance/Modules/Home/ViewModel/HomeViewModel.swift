//
//  HomeViewModel.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 5/11/24.
//

import Foundation

import SwiftUI

class HomeViewModel: ObservableObject, ViewModelProtocol {
    
    
    @Published var transactions: [Transaction] = []
    @Published var budgets: [Budget] = []
    
    private let dataSource: SwiftDataService
    
    init(dataSource: SwiftDataService = SwiftDataService.shared) {
        self.dataSource = dataSource
        fetchTransaction()
        fetchBudgets()
    }
    
    func calculateAmount(for account: TransactionAccount, _ transactions: [Transaction]) -> Double {
        let income = transactions
            .filter { $0.account == account && $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == account && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        return income - expense
    }
    
    func fetchBudgets() {
        budgets = dataSource.fetch()
    }
}

