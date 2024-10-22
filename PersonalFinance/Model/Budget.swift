//
//  Budget.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import Foundation

struct Budget: Identifiable {
    let id = UUID()             // ID único para cada presupuesto
    let name: String            // Nombre del presupuesto (categoría o propósito)
    let max: Double             // Presupuesto máximo asignado
    let spent: Double           // Cantidad ya gastada
    
    // Calcula el porcentaje gastado en base al presupuesto máximo
    var percentageSpent: Double {
        return (spent / max) * 100
    }
    
    // Devuelve si el presupuesto está sobrepasado
    var isOverBudget: Bool {
        return spent > max
    }
}
