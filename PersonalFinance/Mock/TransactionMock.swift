//
//  TransactionMock.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import Foundation

// Creando datos simulados
let mockTransactions: [Transaction] = [
    Transaction(title: "Bravo Zen Spa",   amount: 25.0,  date: Date(), type: .expense), // Gasto
    Transaction(title: "Alpha Analytics", amount: 450.0, date: Date().addingTimeInterval(-86400),     type: .income), // Ingreso de ayer
    Transaction(title: "Echo Game Store", amount: 21.50, date: Date().addingTimeInterval(-2 * 86400), type: .expense), // Gasto de hace dos días
    Transaction(title: "Food Merchant",   amount: 21.50,  date: Date().addingTimeInterval(-3 * 86400), type: .expense), // Ingreso de hace tres días
]

