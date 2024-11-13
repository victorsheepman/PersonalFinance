//
//  BudgetCard.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 23/10/24.
//

import SwiftUI

struct BudgetsCard: View {
    
    @Environment(\.modelContext) var context
    
    @State private var isPresented: Bool = false
    
    var budget: Budget
    
    var free: Double {
        budget.max - budget.spent
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            header
            
            Text("Maximum of $\(budget.max, specifier: "%.2f")")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .padding(.top, 2)
            
            ProgressView(value: budget.spent, total: budget.max)
                .accentColor(budget.theme.color)
            
            LazyVGrid(columns: Constants.columns, spacing: 10) {
                AmountTitle(title: "Spent", amount: budget.spent, color: budget.theme.color)
                
                AmountTitle(title: "Free", amount: free, color: Color("Beige-100"))
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    var header: some View {
        HStack {
            Circle()
                .fill(budget.theme.color)
                .frame(width: 16, height: 16)
            
            Text(budget.category.rawValue)
                .font(.title2.bold())
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            Button("",systemImage: "trash",role: .destructive){
                withAnimation{
                    context.delete(budget)
                }
                
            }
        }
    }
}

fileprivate struct AmountTitle: View {
    
    var title: String
    var amount: CGFloat = 0
    var color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("$\(amount, specifier: "%.2f")")
                    .font(.system(size: 14).bold())
                    .foregroundStyle(.black)
            }
        }
    }
}

