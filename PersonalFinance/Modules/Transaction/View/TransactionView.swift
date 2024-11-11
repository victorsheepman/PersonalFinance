//
//  TransactionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 24/10/24.
//

import SwiftUI
import SwiftData

struct TransactionView: View {
    
    @StateObject var viewModel: TransactionViewModel = TransactionViewModel()
    
    @State private var isPresented: Bool = false
    @State private var searchText: String = ""
    
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
            TransactionForm(isPresented: $isPresented)
        }
        .padding()
        .background(Color("Background"))
    }
    
}



#Preview {
    TransactionView()
        .modelContainer(Transaction.preview)
}
