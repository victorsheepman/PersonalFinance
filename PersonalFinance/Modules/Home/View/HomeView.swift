//
//  HomeView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI
import Charts
import SwiftData


let columns = [
    GridItem(.flexible(), alignment: .leading),
    GridItem(.flexible(), alignment: .leading)  
]


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
                        BudgetSectionView(budgets: budgets, columns: columns)
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


struct TransactionSectionView: View {
    let transactions: [Transaction]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transactions")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(Color("Grey-900"))
            
            ForEach(transactions, id: \.id) { transaction in
                TransactionCellView(transaccion: transaction)
                
                if transaction.id != transactions.last?.id {
                    Divider()
                        .background(Color("Grey-100"))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
}

struct BudgetSectionView: View {
    let budgets: [Budget]
    let columns: [GridItem]

    var body: some View {
        VStack {
            HStack {
                Text("Budgets")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(Color("Grey-900"))
                Spacer()
            }
            
            PieChart(budgets: budgets)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(budgets, id: \.id) { budget in
                    BudgetCellView(budget: budget)
                }
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
}


final class HomeViewModel: ObservableObject {
    @Query(sort: \Transaction.date) var transactions: [Transaction]
    @Query(sort: \Budget.id) var budgets: [Budget]

    var transactionSorted: [Transaction] {
        transactions.suffix(3).sorted { $0.date > $1.date }
    }

    func calculateAmount(for account: TransactionAccount) -> Double {
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


