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
    @State private var selectedType: TransactionType = .expense
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            
            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .disableAutocorrection(true)
           
            
            Picker("Type", selection: $selectedType) {
                ForEach(TransactionType.allCases) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            if selectedType == .expense {
                Picker("Budget", selection: $selectedBudget) {
                    Text("General").tag(nil as Budget?)
                    ForEach(viewModel.budgets) { budget in
                        Text(budget.category.rawValue)
                            .tag(budget as Budget?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
         
            DatePicker(
                "Date",
                selection: $date,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            
            
            Button(action: {
                submitTransaction()
            }) {
                Text("Add Budget")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Grey-900"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
        }.onAppear{
            viewModel.getBudgets()
        }
    }
    
    private func submitTransaction() {
        
        if let selectedAmount = Double(amount) {
            
            viewModel.addTransaction(to: selectedBudget, title: title, amount: selectedAmount, date: date, type: selectedType)
            
            
            isPresented = false
            amount = "0"
            title = ""
            
        }
    }
}

#Preview {
    TransactionForm(viewModel: BudgetViewModel(), isPresented: .constant(true))
}
