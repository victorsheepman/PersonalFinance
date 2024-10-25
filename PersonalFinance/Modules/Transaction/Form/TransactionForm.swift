//
//  TransactionForm.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import SwiftUI

struct TransactionForm: View {
    
    @ObservedObject var viewModel: BudgetViewModel
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var date = Date()
    @State private var selectedBudget: Budget? = nil
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            
            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .disableAutocorrection(true)
            
            Picker("Budget Theme", selection: $selectedBudget) {
                ForEach(viewModel.budgets) { budget in
                    Text(budget.category.rawValue) // Muestra el valor del enum como texto
                        .tag(budget as Budget?) // Asegúrate de asignar el tag correcto
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedBudget) { newBudget in
                // Aquí puedes manejar cualquier acción al cambiar el presupuesto
                print("Selected budget: \(String(describing: newBudget))")
            }
            
            DatePicker(
                "Date",
                selection: $date,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
        }
    }
}

#Preview {
    TransactionForm(viewModel: BudgetViewModel())
}
