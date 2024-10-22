//
//  Budget.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import Foundation
import SwiftUI

struct Budget: Identifiable {
    let id = UUID()
    let category: BudgetCategory
    let max: Double
    let spent: Double
    let theme: BudgetTheme
    
    
    var percentageSpent: Double {
        return (spent / max) * 100
    }
    
    
    var isOverBudget: Bool {
        return spent > max
    }
}


enum BudgetCategory: String, CaseIterable, Identifiable {
    
    case entertainment = "Entertainment"
    case bills = "Bills"
    case diningOut = "Dining Out"
    case personalCare = "Personal Care"
    case groceries = "groceries"
    case transportation = "Transportation"
    case education = "Education"
    
    var id: String { rawValue }
}


enum BudgetTheme: String, CaseIterable, Identifiable {
    case cyan = "Cyan"
    case green = "Green"
    case yellow = "Yellow"
    case navy = "Navy"
    case red = "Red"
    case purple = "Purple"
    case turquoise = "Turquoise"
    
    var id: String { rawValue }
 
    var color: Color {
        Color(rawValue) 
    }
}
