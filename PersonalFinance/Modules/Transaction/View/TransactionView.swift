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
    @State private var budgetSelected: BudgetCategory? = nil
    
    var transactionFiltered: [Transaction] {
        var filtered = viewModel.transactions
        if !search.isEmpty {
            filtered = filtered.filter { $0.title.contains(search) }
        }
        
        if let currentBudget = budgetSelected {
           filtered = filtered.filter { $0.budget?.category.rawValue == currentBudget.rawValue }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    List {
                        HStack{
                            TextField("Search Transaction", text: $search)
                           
                            Menu {
                                ForEach(viewModel.availableBudgets) { budget in
                                    Button(budget.category.rawValue) {
                                        print(budget.category.rawValue)
                                    }
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                    .foregroundStyle(.black)
                            }
                        }
                        ForEach(transactionFiltered) { t in
                            NavigationLink(destination: TransactionForm(transactionToEdit: t, viewModel: viewModel, isPresented:$isPresented )) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(t.title)
                                        Text(t.budget?.category.rawValue ?? "General")
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    
                                    VStack {
                                        Text("\(t.type == .income ? "+" : "-")\(t.amount, specifier: "%.2f")$")
                                            .foregroundColor(t.type == .income ? Color("Green") : Color("Red"))
                                        
                                        Text(t.date.formattedAsString())
                                            .font(.system(size: 12))
                                            .foregroundStyle(Color("Grey-500"))
                                        
                                    }
                                }
                            }
                        }.onDelete(perform: viewModel.removeTransaction)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text("Transactions")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        Spacer()
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
            .sheet(isPresented: $isPresented) {
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
        }.onAppear {
            viewModel.getTransactions()
        }
        
    }
    
}



#Preview {
    TransactionView()
}
