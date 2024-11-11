//
//  TransactionListView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 11/11/24.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    @Query(sort: \Transaction.date) var transactions: [Transaction]
    @State private var isPresented: Bool = false
    @StateObject var viewModel: TransactionViewModel = TransactionViewModel()
    
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
                NavigationLink(destination:
                                TransactionForm(
                                    transactionToEdit: t,
                                    viewModel: viewModel,
                                    isPresented:$isPresented
                                )
                ) {
                    TransactionCellView(transaccion: t)
                }
            }.onDelete { indexSet in
                if let index = indexSet.first {
                    let transactionID = transactions[index].id
                    viewModel.removeTransaction(transactionID)
                }
            }
        }
    }
}



#Preview {
    TransactionListView(filterString: "")
        .modelContainer(Transaction.preview)
}
