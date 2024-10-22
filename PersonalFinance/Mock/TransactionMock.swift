//
//  TransactionMock.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import Foundation

// Creando datos simulados
let mockTransactions: [Transaction] = [

    Transaction(sender: "Salary", amount: 3000.00, date: Date(), category: nil), // Sin categoría
    Transaction(sender: "Freelance Work", amount: 500.00, date: Date().addingTimeInterval(-86400), category: nil), // Sin categoría
    
   
    Transaction(sender: "Grocery Store", amount: -45.00, date: Date(), category: .personalCare),
    Transaction(sender: "Movie Night", amount: -12.50, date: Date().addingTimeInterval(-86400), category: .entertainment),

]
