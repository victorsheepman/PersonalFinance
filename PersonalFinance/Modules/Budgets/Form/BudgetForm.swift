//
//  BudgetForm.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 23/10/24.
//

import SwiftUI

struct BudgetForm: View {
    
    var budgetToEdit: Budget? = nil
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: BudgetViewModel
    
    @State private var selectedTheme: BudgetTheme = .cyan
    @State private var usedColors: Set<BudgetTheme> = [.cyan]
    @State private var selectedCategory: BudgetCategory = .entertainment
    @State private var maxSpent: String = ""
    
    private var usedThemes: Set<BudgetTheme> {
        Set(viewModel.budgets.map { $0.theme })
    }
    
    private var usedCategories: Set<BudgetCategory> {
        Set(viewModel.budgets.map { $0.category })
    }
    
    var body: some View {
        Form {
            Picker("Budget Category", selection: $selectedCategory) {
                ForEach(BudgetCategory.allCases.filter { !usedCategories.contains($0) || budgetToEdit?.category == $0 }) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            TextField("Maximum Spending", text: $maxSpent)
                .keyboardType(.decimalPad)
                .disableAutocorrection(true)
            
            Picker("Budget Theme", selection: $selectedTheme) {
                ForEach(BudgetTheme.allCases.filter { !usedThemes.contains($0) || budgetToEdit?.theme == $0 }) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Button(action: {
                submitBudget()
            }) {
                Text("Add Budget")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Grey-900"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            if let budget = budgetToEdit {
                selectedCategory = budget.category
                maxSpent = String(budget.max)
                selectedTheme = budget.theme
            }
        }
        
    }
    
    private func submitBudget() {
        if let max = Double(maxSpent) {
            
            if let budget = budgetToEdit {
                viewModel.updateBudget(
                    budget: budget,
                    newCategory: selectedCategory,
                    newMax: max,
                    newSpent: budget.spent,
                    newTheme: selectedTheme
                )
            } else {
                viewModel.addBudget(category: selectedCategory, max: max, spent: 0, theme: selectedTheme)
            }
            
            isPresented = false
            maxSpent = "0"
            
        }
    }
}

#Preview {
    BudgetForm(isPresented: .constant(true), viewModel: BudgetViewModel())
}
