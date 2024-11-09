//
//  BudgetSectionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 9/11/24.
//

import SwiftUI

struct BudgetSectionView: View {
    let budgets: [Budget]
    let columns: [GridItem]
    
    private var lastBudgetID: UUID? {
        budgets.last?.id
    }

    var body: some View {
        VStack {
            PieChart(budgets: budgets)
            
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

