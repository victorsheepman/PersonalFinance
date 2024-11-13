//
//  TransactionListView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 11/11/24.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    
    @Environment(\.modelContext) var context
    @Query(sort: \Transaction.date) var transactions: [Transaction]
    @Query(sort: \Budget.id) var budgets: [Budget]
    @State private var isPresented: Bool = false
  
    init(filterString: String) {
        let predicate = #Predicate<Transaction> { transaction in
            transaction.title.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _transactions = Query(filter: predicate)
    }
    
    var body: some View {
        List {
            ForEach(transactions, id: \.id) { t in
                TransactionCellView(transaccion: t)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    context.delete(transactions[index])
                    removeTransactionFromBudget(transactions[index])
                }
            }
        }
        .overlay {
            if transactions.isEmpty {
                ContentUnavailableView {
                    Label("No Transactions", systemImage: "tray.fill")
                }
            }
        }
    }
    
   private func removeTransactionFromBudget(_ transaction: Transaction) -> Void {
    
       guard let selectedBudget = transaction.budget else {
           return
       }
       
       let budget = budgets.first(where: { $0.id == selectedBudget.id })
        
       guard let index = budget?.transactions.firstIndex(where: { $0.id == transaction.id }) else { return }
       
       budget?.transactions.remove(at: index)
       budget?.spent -= transaction.amount
       print(budget?.spent ?? "")
       try? context.save()
    }
}



#Preview {
    TransactionListView(filterString: "")
        .modelContainer(Transaction.preview)
}
