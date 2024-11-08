//
//  TransactionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 24/10/24.
//

import SwiftUI

struct TransactionView: View {
    
    @StateObject var viewModel: TransactionViewModel = TransactionViewModel()
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var budgetSelected: BudgetCategory?
    
    var transactionFiltered: [Transaction] {
        var filtered = viewModel.transactions
        if !search.isEmpty {
            filtered = filtered.filter { $0.title.contains(search) }
        }
        
        if let currentBudget = budgetSelected {
           filtered = filtered.filter { $0.budget?.category.rawValue == currentBudget.rawValue }
        }
        
        return filtered.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        BackgroundContainer(isPresented: $isPresented, title: "Transactions"){
            VStack {
                List {
                    transactionFilter
                    transactionList
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            transactionFormContainer
        }
        .onAppear() {
            viewModel.fetchTransactions()
        }
    }
    
    private var transactionFilter: some View {
        HStack{
            TextField("Search Transaction", text: $search)
           
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

    }
    
    private var transactionList: some View {
        ForEach(transactionFiltered, id: \.id) { t in
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
                let transactionID = transactionFiltered[index].id
                viewModel.removeTransaction(transactionID)
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



#Preview {
    TransactionView()
}
