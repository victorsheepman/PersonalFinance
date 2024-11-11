//
//  TransactionForm.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import SwiftUI
import SwiftData

enum TransactionValidationError: Error {
    case emptyTitle
    case invalidAmount
    
    var errorMessage: String {
        switch self {
        case .emptyTitle:
            return "The title is empty"
        case .invalidAmount:
            return "Invalid amount entered."
        }
    }
}

struct TransactionForm: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Budget.id) var budgets: [Budget]

    @State private var title: String = ""
    @State private var amount: CGFloat = 0
    @State private var selectedDate = Date()
    @State private var selectedBudget: Budget? = nil
    @State private var selectedType: TransactionType = .expense
    @State private var selectedAccount: TransactionAccount = .basic
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @Binding var isPresented: Bool
    
    var aviableBudgets: [Budget] {
        budgets.filter { !$0.isOverBudget }
    }
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
        
    var body: some View {
        Form {
            TextField("Title", text: $title)
            
      
            TextField("Amount", value: $amount, formatter: formatter)
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
            .datePickerStyle(.graphical)
            
            
            Button(action: {
                submitTransaction()
            }) {
                Text("Add")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Grey-900"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func submitTransaction() {
        switch validateTransaction() {
            case .success:
                addTransaction()
            case .failure(let error):
                alertMessage = error.errorMessage
                showAlert = true
            }
    }
    
    
    private func validateTransaction() -> Result<Void, TransactionValidationError> {
        
        return .success(())
    }

    private func addTransaction() {
        let transaction = Transaction(
            title: title,
            amount: amount,
            date: selectedDate,
            type: selectedType,
            account: selectedAccount,
            budget: selectedBudget
        )
        
        context.insert(transaction)
        dismiss()
    }

    
    
   
}

#Preview {
    TransactionForm(isPresented: .constant(true))
}
