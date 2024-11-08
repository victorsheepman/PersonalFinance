//
//  ViewModelProtocol.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 7/11/24.
//

import Foundation

protocol ViewModelProtocol {
    var budgets: [Budget] { get set }
    func fetchBudgets() -> Void
}

extension ViewModelProtocol {
    var transactions: [Transaction] {
        return []
    }
    func fetchTransactions() {
        
    }
}
