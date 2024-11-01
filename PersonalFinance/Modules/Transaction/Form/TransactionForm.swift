//
//  TransactionForm.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import SwiftUI

struct TransactionForm: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var transactionToEdit: Transaction? = nil
    
    @ObservedObject var viewModel: TransactionViewModel
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var selectedDate = Date()
    @State private var selectedBudget: Budget? = nil
    @State private var selectedType: TransactionType = .expense
    @State private var selectedAccount: TransactionAccount = .basic
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
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
                    ForEach(viewModel.availableBudgets.filter { !$0.isOverBudget }) { budget in
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
            .datePickerStyle(.graphical)
            
            
            Button(action: {
                submitTransaction()
            }) {
                Text(transactionToEdit == nil ? "Add" : "Edit")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Grey-900"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
        }.onAppear{
            viewModel.getAvailableBudgets()
            if let transaction = transactionToEdit {
                title = transaction.title
                selectedDate = transaction.date
                amount = String(transaction.amount)
                selectedBudget = transaction.budget
                selectedType = transaction.type
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func submitTransaction() {
        if let budget = selectedBudget, budget.isOverBudget {
            alertMessage = "Cannot add more transactions to this budget as it has reached its maximum limit."
            showAlert = true
            return
        }
        
        guard let selectedAmount = Double(amount) else {
            return
        }
 
        
        if let transaction = transactionToEdit {
            
            let newTitle  = title != transaction.title ? title : nil
            let newAmount = selectedAmount != transaction.amount ? selectedAmount : nil
            var newBudget = selectedBudget != transaction.budget ? selectedBudget : nil
            let newDate   = selectedDate != transaction.date ? selectedDate : nil
            let newType   = selectedType != transaction.type ? selectedType : nil
                    
            viewModel.updateTransaction(
                transaction: transaction,
                newTitle: newTitle,
                newAmount: newAmount,
                newBudget: selectedBudget,
                newDate: newDate,
                newType: newType,
                newAccount: selectedAccount
            )
            dismiss()
        } else {
            
            let newTransaction = Transaction(title: title, amount: selectedAmount, date: selectedDate, type: selectedType, account: selectedAccount)
          
            viewModel.addTransaction(to: selectedBudget, transaction: newTransaction)
            isPresented = false
            amount = "0"
            title = ""
        }
     
    }
}

#Preview {
    TransactionForm(viewModel: TransactionViewModel(), isPresented: .constant(true))
}
