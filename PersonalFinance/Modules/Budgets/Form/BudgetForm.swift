//
//  BudgetForm.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 23/10/24.
//

import SwiftUI
import SwiftData

struct BudgetForm: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Budget.id) private var budgets: [Budget]

    
    @State private var selectedTheme: BudgetTheme = .cyan
    @State private var usedColors: Set<BudgetTheme> = [.cyan]
    @State private var selectedCategory: BudgetCategory = .entertainment
    @State private var maxSpent: CGFloat = 0
    @State private var showAlert: Bool = false
 
    
    private var usedThemes: Set<BudgetTheme> {
        Set(budgets.map { $0.theme })
    }
    
    private var usedCategories: Set<BudgetCategory> {
        Set(budgets.map { $0.category })
    }
    
    let initialSpent: Double = 0.0
    
    var availableCategories: [BudgetCategory] {
        BudgetCategory.allCases.filter { !usedCategories.contains($0) }
    }
    
    var availableTheme: [BudgetTheme] {
        BudgetTheme.allCases.filter { !usedThemes.contains($0) }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Maximum Spending", value: $maxSpent, formatter: Constants.formatter)
                    .keyboardType(.decimalPad)
                    .disableAutocorrection(true)
                
                Picker("Budget Category", selection: $selectedCategory) {
                    ForEach(availableCategories, id:\.id) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker("Budget Theme", selection: $selectedTheme) {
                    ForEach(availableTheme, id: \.id) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
            }
            .navigationTitle("Add Budget")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                       dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addBudget()
                    }
                    .tint(.blue)
                    .buttonStyle(.borderedProminent)
                    .disabled( maxSpent <= 0)
                    
                }
            }
        }
        
    }
    
   
    private func addBudget() {
        let budget = Budget(
            category: selectedCategory,
            max: maxSpent,
            spent: initialSpent,
            theme: selectedTheme,
            transactions: []
        )
        
        context.insert(budget)
        try? context.save()
        dismiss()
    }
}

#Preview {
    BudgetForm()
        .modelContainer(Budget.preview)
}
