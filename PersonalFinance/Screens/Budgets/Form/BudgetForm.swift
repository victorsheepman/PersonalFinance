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

    @State private var selectedTheme: BudgetTheme?
    @State private var selectedCategory: BudgetCategory?
    @State private var maxSpent: Double = 0
    @State private var showAlert: Bool = false
 
    
    private var usedThemes: Set<BudgetTheme> {
        Set(budgets.map { $0.theme })
    }
    
    private var usedCategories: Set<BudgetCategory> {
        Set(budgets.map { $0.category })
    }
    
    private let initialSpent: Double = 0.0
    
    private var availableCategories: [BudgetCategory] {
        BudgetCategory.allCases.filter { !usedCategories.contains($0) }
    }
    
    private var availableTheme: [BudgetTheme] {
        BudgetTheme.allCases.filter { !usedThemes.contains($0) }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Maximum Spending", value: $maxSpent, formatter: Constants.formatter)
                    .keyboardType(.decimalPad)
                    .disableAutocorrection(true)
                
                Picker("Budget Category", selection: $selectedCategory) {
                    Text("Select a category").tag(nil as BudgetCategory?)
                    ForEach(availableCategories, id:\.id) { category in
                        Text(category.rawValue).tag(category as BudgetCategory?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker("Budget Theme", selection: $selectedTheme) {
                    Text("Select a theme").tag(nil as BudgetTheme?)
                    ForEach(availableTheme, id: \.id) { theme in
                        Text(theme.rawValue).tag(theme as BudgetTheme?)
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
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .tint(.blue)
                    .buttonStyle(.borderedProminent)
                    .disabled( maxSpent <= 0 || selectedCategory == nil ||  selectedTheme == nil)
                    
                }
            }
        }
        
    }
    
   
    private func save() {
        guard let theme = selectedTheme, let category = selectedCategory else {
            return
        }
        let budget = Budget(
            category: category,
            max: maxSpent,
            spent: initialSpent,
            theme: theme
        )

        context.insert(budget)
        try? context.save()
        
    }
}

#Preview {
    BudgetForm()
        .modelContainer(Budget.preview)
}
