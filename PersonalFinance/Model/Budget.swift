//
//  Budget.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Budget {
    
    @Attribute(.unique) var id: UUID
    
    var category: BudgetCategory
    var max: Double
    var spent: Double
    var theme: BudgetTheme
    
    
    @Transient var percentageSpent: Double {
        return (spent / max) * 100
    }
    
    
    @Transient var isOverBudget: Bool {
        return spent > max
    }
    
    init(id: UUID, category: BudgetCategory, max: Double, spent: Double, theme: BudgetTheme) {
        self.id = id
        self.category = category
        self.max = max
        self.spent = spent
        self.theme = theme
    }
}


enum BudgetCategory: String, CaseIterable, Identifiable, Codable {
    
    case entertainment = "Entertainment"
    case bills = "Bills"
    case diningOut = "Dining Out"
    case personalCare = "Personal Care"
    case groceries = "groceries"
    case transportation = "Transportation"
    case education = "Education"
    
    var id: String { rawValue }
}


enum BudgetTheme: String, CaseIterable, Identifiable, Codable {
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
