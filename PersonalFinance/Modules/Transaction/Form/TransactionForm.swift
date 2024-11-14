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
    @State private var selectedType: TransactionType?
    @State private var selectedAccount: TransactionAccount?
    
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
                    Text("Select a type").tag(nil as TransactionType?)
                    ForEach(TransactionType.allCases) { type in
                        Text(type.rawValue)
                            .tag(type as TransactionType?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                
                Picker("Account", selection: $selectedAccount) {
                    Text("Select an account").tag(nil as TransactionAccount?)
                    ForEach(TransactionAccount.allCases) { account in
                        Text(account.rawValue)
                            .tag(account as TransactionAccount?)
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
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .tint(.blue)
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || amount <= 0 || selectedType == nil || selectedAccount == nil)
                }
            }
            
        }
        
    }

    private func save() {
        guard let type = selectedType, let account = selectedAccount else {
            return
        }
        let transaction = Transaction(
            title: title,
            amount: amount,
            date: selectedDate,
            type: type,
            account: account
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
