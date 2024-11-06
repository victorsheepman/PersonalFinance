//
//  BudgetCellView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 6/11/24.
//

import SwiftUI

struct BudgetCellView: View {
    var budget: Budget
    var body: some View {
        HStack {
            
            Circle()
                .fill(budget.theme.color)
                .frame(width: 10, height: 10)
            
            Text(budget.category.rawValue)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Text("$\(budget.spent, specifier: "%.2f")")
                .font(.system(size: 14).bold())
                .foregroundStyle(.primary)
                .frame(width: 80, alignment: .trailing)
            
            
            Text("of $\(budget.max, specifier: "%.2f") limit")
                .font(.callout)
                .foregroundStyle(.secondary)
                .frame(width: 120, alignment: .trailing)
        }
    }
}

