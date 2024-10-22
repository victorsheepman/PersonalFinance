//
//  BudgetMock.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import Foundation

let budgetMock: [Budget] = [
    Budget(category: .entertainment, max: 50.00,  spent: 25.00,  theme: .green),
    Budget(category: .bills,         max: 750.00, spent: 250.00, theme: .cyan),
    Budget(category: .diningOut,     max: 75.00,  spent: 67.00,  theme: .yellow),
    Budget(category: .personalCare,  max: 100.00, spent: 65.00,  theme: .navy)
]
