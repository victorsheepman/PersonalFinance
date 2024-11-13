//
//  BudgetSectionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 9/11/24.
//

import SwiftUI
import SwiftData

struct BudgetSectionView: View {
    @Query(sort: \Budget.id) var budgets: [Budget]
    
    private var lastBudgetID: UUID? {
        budgets.last?.id
    }

    var body: some View {
        VStack {
            PieChart()
            
            Text("Spending Summary")
                .font(.system(size: 20).bold())
                .padding(.trailing, 148)
            
            ForEach(budgets, id: \.id) { budget in
                BudgetCellView(budget: budget)
                if budget.id != lastBudgetID {
                    Divider()
                        .background(Color("Grey-100"))
                }
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
}

fileprivate struct BudgetCellView: View {
    var budget: Budget
    var body: some View {
        HStack {
            
            Circle()
                .fill(budget.theme.color.gradient)
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



#Preview {
    BudgetSectionView()
        .modelContainer(Budget.preview)
}


