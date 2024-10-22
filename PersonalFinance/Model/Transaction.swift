//
//  Transaction.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let sender: String
    let amount: Double
    let date: Date
    let category: BudgetCategory?
    
}
