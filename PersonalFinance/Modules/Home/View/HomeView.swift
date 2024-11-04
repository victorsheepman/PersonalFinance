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
    
    private let dataSource: SwiftDataService
    
    @State private var transactions: [Transaction]?
    @State private var budgets: [Budget]?
    
    init(dataSource: SwiftDataService = SwiftDataService.shared) {
        self.dataSource = dataSource
    }
    
    var basicAmount: Double {
        guard let transactions = self.transactions else {
            return 0.0
        }
        
        let income = transactions
            .filter { $0.account == .basic }
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == .basic }
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        return income - expense
    }
    
    var personalAmount: Double {
        guard let transactions = self.transactions else {
            return 0.0
        }
        
        let income = transactions
            .filter { $0.account == .person }
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == .person }
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        return income - expense
    }
    
    var savingAmount: Double {
        guard let transactions = self.transactions else {
            return 0.0
        }
        
        let income = transactions
            .filter { $0.account == .saving }
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == .saving }
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        return income - expense
    }
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        
                        
                        BalanceCardView(title: "Necesidades Basicas 50%", balance: String(basicAmount), isDark: true)
                        BalanceCardView(title: "Gastos Prescindibles 30%", balance: String(personalAmount))
                        BalanceCardView(title: "Ahorro 20%", balance: String(savingAmount))
                        
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
                fetchTransaction()
                fetchBudget()
            }
        }
        
    }
   
    var transactionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transactions")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(Color("Grey-900"))
                
            if let transactions = self.transactions {
                ForEach(transactions.suffix(3).sorted { $0.date > $1.date }, id: \.id) { t in
                    
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
                    
                    if t.id != transactions.suffix(3).last?.id {
                        Divider()
                            .background(Color("Grey-100"))
                    }
                }
            }
            Spacer()
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
            
            if let budgets = self.budgets {
                PieChart(budgets: budgets)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    ForEach(budgets) { budget in
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
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    private func fetchTransaction() {
        transactions = dataSource.fetch()
    }
    private func fetchBudget() {
        budgets = dataSource.fetch()
    }    
}

#Preview {
    HomeView()
}
