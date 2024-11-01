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
    
    private let dataSource: ItemDataSource
    
    @State private var transactions: [Transaction]?
    
    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        
                        
                        BalanceCardView(title: "Necesidades Basicas 50%", balance: String(getAmount(from: .basic)), isDark: true)
                        BalanceCardView(title: "Gastos Prescindibles 30%", balance: String(getAmount(from: .person)))
                        BalanceCardView(title: "Ahorro 20%", balance: String(getAmount(from: .saving)))
                        
                        //transactionSection
                        
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
                fetchTransaction()
            }
        }
        
    }
   
    var transactionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(mockTransactions, id: \.id) { t in
                
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
    
    private func fetchTransaction() {
        transactions = dataSource.fetch()
    }
    private func getAmount(from account: TransactionAccount) -> Double {
        guard let transactions = self.transactions else {
            return 0.0
        }
        
        let income = transactions
            .filter { $0.account == account }
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == account }
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        return income - expense
    }
}

#Preview {
    HomeView()
}
