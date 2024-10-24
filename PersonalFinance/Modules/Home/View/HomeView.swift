//
//  HomeView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI
import Charts



let columns = [
    GridItem(.flexible(), alignment: .leading),
    GridItem(.flexible(), alignment: .leading)  
]


struct HomeView: View {
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        
                        
                        BalanceCardView(title: "Current Balance", balance: "4,836.00", isDark: true)
                        BalanceCardView(title: "Income", balance: "3,814.25")
                        BalanceCardView(title: "Expenses", balance: "1,700.50")
                        
                        transactionSection
                        
                        budgetSection
              
                        
                    }
                    .padding()
                    .padding(.bottom, 100)
                }.navigationTitle("Overview")
                
            }
        }
        
    }
    
    var transactionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            NavigationLink(value:"Transaction") {
                HStack{
                    
                    Text("Transactions")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(Color("Grey-900"))
                    
                    Spacer()
                    
                    Label("View All", systemImage:"arrowtriangle.forward.fill")
                        .labelStyle(RightIconLabelStyle())
                        .font(.system(size: 14))
                        .foregroundStyle(Color("Grey-500"))
                    
                }
            }
            .foregroundColor(.secondary)
            .padding(.bottom, 12)
            
            ForEach(mockTransactions, id: \.id) { t in
                
                TransactionDetailCell(sender: t.sender, amount: t.amount, date: t.date)
                    .listRowSeparator(.hidden, edges: .all)
                    .padding(.vertical, 2)
                
                if t.id != mockTransactions.last?.id {
                    Divider()
                        .background(Color("Grey-100"))
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    var budgetSection: some View {
        VStack{
            NavigationLink(value:"Transaction") {
                HStack{
                    
                    Text("Budgets")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(Color("Grey-900"))
                    
                    Spacer()
                    
                    Label("See Details", systemImage:"arrowtriangle.forward.fill")
                        .labelStyle(RightIconLabelStyle())
                        .font(.system(size: 14))
                        .foregroundStyle(Color("Grey-500"))
                    
                }
            }
            .foregroundColor(.secondary)
            .padding(.bottom, 12)
            
            PieChart(budgets: budgetMock)
            
            LazyVGrid(columns: columns, spacing: 10) {
                
                ForEach(budgetMock) { budget in
                    HStack{
                        Circle()
                            .fill(budget.theme.color)
                            .frame(width: 10, height: 10)
                        VStack(alignment: .leading) {
                            Text(budget.category.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text("$\(budget.max, specifier: "%.2f")")
                                .font(.system(size: 14).bold())
                                .foregroundStyle(.black)
                            
                        }
                    }
                }
            }
            .padding(.top, 20)
           
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
}

#Preview {
    HomeView()
}
