//
//  TransactionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 24/10/24.
//

import SwiftUI
import SwiftData

struct TransactionView: View {
    
    @Query(sort: \Transaction.date) var transactions: [Transaction]
    @StateObject var viewModel: TransactionViewModel = TransactionViewModel()
    
    @State private var isPresented: Bool = false
    @State private var searchText: String = ""
    @State private var budgetSelected: BudgetCategory?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TransactionListView(filterString: searchText)
                        .searchable(text: $searchText)
                }
            }
            .navigationTitle("Transactions")
            .sheet(isPresented: $isPresented) {
                transactionFormContainer
            }
            .toolbar {
                ToolbarItem() {
                    Menu {
                        Button("All Transactions") {
                            budgetSelected = nil
                        }
                        ForEach(BudgetCategory.allCases, id: \.id) { budget in
                            
                            Button(budget.rawValue) {
                                budgetSelected = budget
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                   
                }
            }
        }
    }
    private var transactionFormContainer: some View {
        VStack {
            HStack(spacing:95) {
                Text("Add New Budget")
                    .font(.title)
                    .bold()
                
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(Color("Grey-500"))
                }
            }
            TransactionForm(viewModel: viewModel, isPresented: $isPresented)
        }
        .padding()
        .background(Color("Background"))
    }
    
}


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
    TransactionView()
        .modelContainer(Transaction.preview)
}
