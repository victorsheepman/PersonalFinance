//
//  BudgetCard.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 23/10/24.
//

import SwiftUI

struct BudgetsCard: View {
    
    var budget: Budget
    
    @ObservedObject var viewModel: BudgetViewModel
    @State private var isPresented: Bool = false
    
    var free: Double {
       budget.max - budget.spent
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                
                Circle()
                    .fill(budget.theme.color)
                    .frame(width: 16, height: 16)
                
                Text(budget.category.rawValue)
                    .font(.title2.bold())
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
            
                Menu {
                    Button("Edit Budget"){
                        print("editing")
                        isPresented = true
                    }
                    Button("Delete Budget", role: .destructive){
                        viewModel.deleteBudget(budget: budget)
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color("Grey-300"))
                }
                    
                
                
            }
            
            Text("Maximum of $\(budget.max, specifier: "%.2f")")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .padding(.top, 2)
            
            ProgressView(value: budget.spent, total: budget.max)
                .accentColor(budget.theme.color)
            
            LazyVGrid(columns: columns, spacing: 10) {
                HStack{
                    Circle()
                        .fill(budget.theme.color)
                        .frame(width: 10, height: 10)
                    VStack(alignment: .leading) {
                        Text("Spent")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("$\(budget.spent, specifier: "%.2f")")
                            .font(.system(size: 14).bold())
                            .foregroundStyle(.black)
                        
                    }
                }
                
                HStack{
                    Circle()
                        .fill(Color("Beige-100"))
                        .frame(width: 10, height: 10)
                    VStack(alignment: .leading) {
                        Text("Free")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("$\(free, specifier: "%.2f")")
                            .font(.system(size: 14).bold())
                            .foregroundStyle(.black)
                        
                    }
                }
                
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
       .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .sheet(isPresented: $isPresented) {
            VStack{
                HStack(spacing:95) {
                    Text("Edit Budget")
                        .font(.title)
                        .bold()
                       
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(Color("Grey-500"))
                    }
                    
                }
                
                BudgetForm(budgetToEdit: budget, isPresented: $isPresented, viewModel: viewModel)
                    
            }
            .padding()
            
        }
    }
}

#Preview {
    BudgetsCard(budget: Budget(id: UUID(), category: .entertainment, max: 50.00,  spent: 25.00,  theme: .green),viewModel: BudgetViewModel() )
}
