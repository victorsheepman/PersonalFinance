//
//  BudgetViewModel.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 23/10/24.
//

import Foundation
import Combine

class BudgetViewModel: ObservableObject {
    @Published var budgets: [Budget] = budgetMock 

    private var cancellables: Set<AnyCancellable> = []

    func addBudget(category: BudgetCategory, max: Double, spent: Double, theme: BudgetTheme) {
        let newBudget = Budget(category: category, max: max, spent: spent, theme: theme)
        budgets.append(newBudget)
    }

    var totalMax: Double {
        budgets.reduce(0) { $0 + $1.max }
    }
    
    var totalSpent: Double {
        budgets.reduce(0) { $0 + $1.spent }
    }
}
