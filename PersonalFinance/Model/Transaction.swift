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
    var amount: Double // Monto de la transacción
    var date: Date // Fecha de la transacción
    var type: TransactionType // Tipo de transacción (ingreso o gasto)
    var budget: Budget?
    
    init(id: UUID = UUID(),title:String, amount: Double, date: Date, type: TransactionType) {
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
        self.type = type
        
    }
}

enum TransactionType: String, CaseIterable, Identifiable, Codable {
    case income = "Income"
    case expense = "Expense"
    
    var id: String { rawValue }
}
