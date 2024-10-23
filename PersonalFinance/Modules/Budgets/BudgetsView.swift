//
//  BudgetsView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI

struct BudgetsView: View {
    var totalMax: Double {
        budgetMock.reduce(0) { $0 + $1.max }
    }
       
     
    var totalSpent: Double {
        budgetMock.reduce(0) { $0 + $1.spent }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                
                ScrollView {
                    VStack {
                        
                       budgetChart
                        VStack(alignment:.leading) {
                            HStack {
                                
                                Circle()
                                    .fill(Color("Green"))
                                    .frame(width: 16, height: 16)
                                
                                Text("Entertainment")
                                    .font(.title2.bold())
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                                
                                
                                    
                                Menu {
                                    Button("Edit Budget"){
                                        print("editing")
                                    }
                                    Button("Delete Budget", role: .destructive){
                                        print("deleting")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(Color("Grey-300"))
                                }
                                    
                                
                                
                            }
                            
                            Text("Maximum of $50.00")
                                .font(.system(size: 16))
                                .foregroundStyle(.secondary)
                                .padding(.top, 2)
                            
                            ProgressView(value: 50.00, total: 100.0)
                                .accentColor(Color("Green"))
                            
                            
                            
                            //CONTINUE.....
                            LazyVGrid(columns: columns, spacing: 10) {
                                HStack{
                                    Circle()
                                        .fill(Color("Green"))
                                        .frame(width: 10, height: 10)
                                    VStack(alignment: .leading) {
                                        Text("Spent")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        
                                        Text("$250.00")
                                            .font(.system(size: 14).bold())
                                            .foregroundStyle(.black)
                                        
                                    }
                                }
                                
                                HStack{
                                    Circle()
                                        .fill(Color("Beige-100"))
                                        .frame(width: 10, height: 10)
                                    VStack(alignment: .leading) {
                                        Text("Free")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        
                                        Text("$750.00")
                                            .font(.system(size: 14).bold())
                                            .foregroundStyle(.black)
                                        
                                    }
                                }
                                
                            }
                            .padding(.top, 20)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(.white))

                        
                        Spacer()
                    }
                    .padding(.bottom, 100)
                    .padding(.horizontal)
                    .padding(.top, 40)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text("Budgets")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        Spacer()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Add button tapped")
                    }) {
                        Text("Add New Budget")
                            .font(.system(size: 14).bold())
                            .foregroundStyle(.white)
                    }
                    .frame(width: 155, height: 53)
                    .background(Color("Grey-900"))
                    .cornerRadius(8)
                    .padding(.top)
                }
            }
        }
    }
    
    var budgetChart: some View {
        VStack {
            PieChart(budgets: budgetMock)
            
            Text("Spending Summary")
                .font(.system(size: 20).bold())
                .padding(.trailing, 148)
            
            ForEach(budgetMock) { budget in
                HStack {
                    
                    Circle()
                        .fill(budget.theme.color)
                        .frame(width: 10, height: 10)
                    
                    Text(budget.category.rawValue)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Text("$\(budget.max, specifier: "%.2f")")
                        .font(.system(size: 14).bold())
                        .foregroundStyle(.primary)
                        .frame(width: 80, alignment: .trailing)
                    
                    
                    Text("of $\(totalMax, specifier: "%.2f") limit")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .frame(width: 120, alignment: .trailing)
                }
                if budget.id != budgetMock.last?.id {
                    Divider()
                        .background(Color("Grey-100"))
                    
                }
                
            }
            .padding(.top, 10)
           
        
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
}

#Preview {
    BudgetsView()
}
