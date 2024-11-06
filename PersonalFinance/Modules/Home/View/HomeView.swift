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
    
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack{
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        
                        
                        BalanceCardView(title: "Necesidades Basicas 50%", balance: viewModel.basicAmount, isDark: true)
                        BalanceCardView(title: "Gastos Prescindibles 30%", balance: viewModel.personalAmount)
                        BalanceCardView(title: "Ahorro 20%", balance: viewModel.savingAmount)
                        
                        transactionSection
                        
                        budgetSection
              
                        
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
            .onAppear {
                viewModel.fetchBudget()
                viewModel.fetchTransaction()
            }
        }
        
    }
   
    var transactionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transactions")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(Color("Grey-900"))
            
            if let transactions = viewModel.transactions {
                
                let transactionSorted = transactions.suffix(3).sorted { $0.date > $1.date }
                
                ForEach(transactionSorted, id: \.id) { t in
                    
                    TransactionCellView(transaccion: t)
                    
                    if t.id != transactions.suffix(3).last?.id {
                        Divider()
                            .background(Color("Grey-100"))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    

    var budgetSection: some View {
        VStack {
            HStack {
                Text("Budgets")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(Color("Grey-900"))
                Spacer()
            }
            
            if let budgets = viewModel.budgets {
                PieChart(budgets: budgets)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(budgets,id: \.id) { budget in
                        BudgetCellView(budget: budget)
                    }
                }
                .padding(.top, 20)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }

}





#Preview {
    HomeView()
}


