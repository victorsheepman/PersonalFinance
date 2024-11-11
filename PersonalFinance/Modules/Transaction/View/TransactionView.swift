//
//  TransactionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 24/10/24.
//

import SwiftUI
import SwiftData

struct TransactionView: View {
    
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
                TransactionForm()
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
}





#Preview {
    TransactionView()
        .modelContainer(Transaction.preview)
}
