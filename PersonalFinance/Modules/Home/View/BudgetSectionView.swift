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

    var body: some View {
        VStack {
            HStack {
                Text("Budgets")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(Color("Grey-900"))
                Spacer()
            }
            
            PieChart(budgets: budgets)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(budgets, id: \.id) { budget in
                    BudgetCellView(budget: budget)
                }
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
}

