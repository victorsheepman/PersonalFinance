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
    
    
    var basicAmount: Double {
        calculateAmount(for: .basic)
    }
    
    var personalAmount: Double {
        calculateAmount(for: .person)
    }
    
    var savingAmount: Double {
        calculateAmount(for: .saving)
    }
    
    private func calculateAmount(for account: TransactionAccount) -> Double {
        let income = transactions
            .filter { $0.account == account && $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == account && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        return income - expense
    }
    
    func fetchTransaction() {
        transactions = dataSource.fetch()
    }
    
    func fetchBudgets() {
        budgets = dataSource.fetch()
    }
}

