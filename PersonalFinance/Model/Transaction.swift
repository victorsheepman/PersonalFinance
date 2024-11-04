//
//  Transaction.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Transaction {
    
    @Attribute(.unique) var id: UUID
    var title: String
    var amount: Double
    var date: Date
    var type: TransactionType 
    var budget: Budget?
    var account: TransactionAccount
    
    init(id: UUID = UUID(),title:String, amount: Double, date: Date, type: TransactionType, account: TransactionAccount, budget:Budget? = nil) {
        self.id      = id
        self.title   = title
        self.amount  = amount
        self.date    = date
        self.type    = type
        self.budget  = budget
        self.account = account
        
    }
}

enum TransactionType: String, CaseIterable, Identifiable, Codable {
    case income = "Income"
    case expense = "Expense"
    
    var id: String { rawValue }
}


enum TransactionAccount: String, CaseIterable, Identifiable, Codable {
    case basic = "50%"
    case person = "30%"
    case saving = "20%"
    
    var id: String { rawValue }
}
