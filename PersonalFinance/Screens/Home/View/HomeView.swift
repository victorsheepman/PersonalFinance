//
//  HomeView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \Transaction.date) var transactions: [Transaction]
    
    private var transactionSorted: [Transaction] {
        transactions.suffix(3).sorted { $0.date > $1.date }
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                ScrollView{
                    VStack(spacing: 15){
                        BalanceCardView(title: "Necesidades Basicas 50%", account: .basic)
                        BalanceCardView(title: "Gastos Prescindibles 30%", account:.person)
                        BalanceCardView(title: "Ahorro 20%", account: .saving)
                        TransactionSectionView(transactions: transactionSorted)
                        BudgetSectionView()
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("Overview")
        }
    }
}
#Preview {
    HomeView()
        .modelContainer(Transaction.preview)
}


