//
//  BudgetsView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI

struct BudgetsView: View {
    
    @State private var isPresented: Bool = false
    @StateObject private var viewModel = BudgetViewModel()
 
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                
                ScrollView {
                    VStack {
                        
                        budgetChart
                        ForEach(viewModel.budgets) { budget in
                            BudgetsCard(budget: budget, viewModel: viewModel)
                                .padding(.top, 24)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 100)
                    .padding(.horizontal)
                    .padding(.top, 40)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text("Budgets")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        Spacer()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }) {
                        Text("Add New Budget")
                            .font(.system(size: 14).bold())
                            .foregroundStyle(.white)
                    }
                    .frame(width: 155, height: 53)
                    .background(Color("Grey-900"))
                    .cornerRadius(8)
                    .padding(.top)
                }
            }
            .sheet(isPresented: $isPresented) {
                VStack{
                    HStack(spacing:95) {
                        Text("Add New Budget")
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
                    
                    BudgetForm(isPresented: $isPresented, viewModel: viewModel)
                        
                }
                .padding()
                
            }
        }
        .onAppear(){
            viewModel.getBudgets()
        }
    }
    
    var budgetChart: some View {
        VStack {
            PieChart(budgets: viewModel.budgets)
            
            Text("Spending Summary")
                .font(.system(size: 20).bold())
                .padding(.trailing, 148)
            
            ForEach(viewModel.budgets) { budget in
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
                if budget.id != viewModel.budgets.last?.id {
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




#Preview {
    BudgetsView()
}
