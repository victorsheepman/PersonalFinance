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
            }.onDelete { indexSet in
                for index in indexSet {
                    context.delete(transactions[index])
                    removeTransactionFromBudget(transactions[index])
                }
            }
        }
    }
    
   private func removeTransactionFromBudget(_ transaction: Transaction) -> Void {
        guard let budget = transaction.budget else {
            return
        }
        
        if let index = budget.transactions?.firstIndex(where: { $0.id == transaction.id }) {
            budget.transactions?.remove(at: index)
            budget.spent -= transaction.amount
        }
    }
}



#Preview {
    TransactionListView(filterString: "")
        .modelContainer(Transaction.preview)
}
