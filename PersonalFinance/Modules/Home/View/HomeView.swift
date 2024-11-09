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
    @Query(sort: \Budget.id) var budgets: [Budget]
    
    var basicAmount: Double {
        calculateAmount(for: .basic)
    }
    
    var personalAmount: Double {
        calculateAmount(for: .person)
    }
    
    var savingAmount: Double {
        calculateAmount(for: .saving)
    }
    
    var transactionSorted: [Transaction] {
        transactions.suffix(3).sorted { $0.date > $1.date }
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                ScrollView{
                    VStack{
                        BalanceCardView(title: "Necesidades Basicas 50%", balance: basicAmount, isDark: true)
                        BalanceCardView(title: "Gastos Prescindibles 30%", balance: personalAmount)
                        BalanceCardView(title: "Ahorro 20%", balance: savingAmount)
                        TransactionSectionView(transactions: transactions)
                        BudgetSectionView(budgets: budgets)
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Overview")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                }
            }
        }
    }
    
    private func calculateAmount(for account: TransactionAccount ) -> Double {
        let income = transactions
            .filter { $0.account == account && $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == account && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        return income - expense
    }
}
#Preview {
    HomeView()
}


