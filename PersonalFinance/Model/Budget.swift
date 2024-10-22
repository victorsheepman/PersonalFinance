//
//  Budget.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import Foundation

struct Budget: Identifiable {
    let id = UUID()
    let name: String
    let max: Double
    let spent: Double
    
    var percentageSpent: Double {
        return (spent / max) * 100
    }
    
    
    var isOverBudget: Bool {
        return spent > max
    }
}
