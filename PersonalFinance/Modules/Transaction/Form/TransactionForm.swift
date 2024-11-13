//
//  TransactionForm.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import SwiftUI
import SwiftData

struct TransactionForm: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Budget.id) private var budgets: [Budget]

    @State private var title: String = ""
    @State private var amount: CGFloat = 0
    @State private var selectedDate = Date()
    @State private var selectedBudget: Budget?
    @State private var selectedType: TransactionType = .expense
    @State private var selectedAccount: TransactionAccount = .basic
    
    var aviableBudgets: [Budget] {
        budgets.filter { !$0.isOverBudget }
    }
   
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                TextField("Amount", value: $amount, formatter: Constants.formatter)
                    .keyboardType(.decimalPad)
                    .disableAutocorrection(true)
                
                Picker("Type", selection: $selectedType) {
                    ForEach(TransactionType.allCases) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                
                Picker("Account", selection: $selectedAccount) {
                    ForEach(TransactionAccount.allCases) { account in
                        Text(account.rawValue)
                            .tag(account)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                if selectedType == .expense {
                    Picker("Budget", selection: $selectedBudget) {
                        Text("General").tag(nil as Budget?)
                        ForEach(aviableBudgets, id: \.id) { budget in
                            Text(budget.category.rawValue)
                                .tag(budget as Budget?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                DatePicker(
                    "Date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                       dismiss()
                    }
                    .tint(.red)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .tint(.blue)
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || amount <= 0)
                }
            }
            
        }
        
    }

    private func save() {
        
        let transaction = Transaction(
            title: title,
            amount: amount,
            date: selectedDate,
            type: selectedType,
            account: selectedAccount
        )
        
        transaction.budget = selectedBudget
        context.insert(transaction)
        
        let budget = budgets.first(where: { $0.id == selectedBudget?.id })
        
        budget?.transactions.append(transaction)
        budget?.spent += transaction.amount
        
        try? context.save()
    }
}

#Preview {
    TransactionForm()
}
