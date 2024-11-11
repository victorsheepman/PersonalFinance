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
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    private var usedThemes: Set<BudgetTheme> {
        Set(viewModel.budgets.map { $0.theme })
    }
    
    private var usedCategories: Set<BudgetCategory> {
        Set(viewModel.budgets.map { $0.category })
    }
    
    var body: some View {
        Form {
            TextField("Maximum Spending", text: $maxSpent)
                .keyboardType(.decimalPad)
                .disableAutocorrection(true)
            
            Picker("Budget Category", selection: $selectedCategory) {
                ForEach(BudgetCategory.allCases.filter { !usedCategories.contains($0) || budgetToEdit?.category == $0 }, id:\.id) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Picker("Budget Theme", selection: $selectedTheme) {
                ForEach(BudgetTheme.allCases.filter { !usedThemes.contains($0) || budgetToEdit?.theme == $0 }, id: \.id) { theme in
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
                loadBudgetData(from: budget)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }
    
    private func submitBudget() {
        guard let max = parseMaxSpent() else { return }
        
        if let budget = budgetToEdit {
            updateExistingBudget(budget, withMax: max)
        } else {
            addNewBudget(withMax: max)
        }
        
        resetForm()
    }

    private func parseMaxSpent() -> Double? {
        guard let max = Double(maxSpent) else {
            alertMessage = "Invalid maximum spending amount."
            showAlert = true
            return nil
        }
        return max
    }

    private func updateExistingBudget(_ budget: Budget, withMax max: Double) {
        viewModel.updateBudget(
            budget: budget,
            newCategory: selectedCategory,
            newMax: max,
            newSpent: budget.spent,
            newTheme: selectedTheme
        )
    }

    private func addNewBudget(withMax max: Double) {
        viewModel.addBudget(
            category: selectedCategory,
            max: max,
            spent: 0,
            theme: selectedTheme
        )
    }
    
    private func resetForm() {
        isPresented = false
        maxSpent = "0"
    }

    private func loadBudgetData(from budget: Budget) {
        selectedCategory = budget.category
        maxSpent = String(budget.max)
        selectedTheme = budget.theme
    }
}

#Preview {
    BudgetForm(isPresented: .constant(true), viewModel: BudgetViewModel())
}
