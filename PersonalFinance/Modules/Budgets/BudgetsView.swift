//
//  BudgetsView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI

struct BudgetsView: View {
    
    @State private var isPresented: Bool = false
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
                        ForEach(budgetMock) { budget in
                            BudgetsCard(budget: budget)
                                .padding(.top, 24)
                        }
                        
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
                        isPresented = true
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
            .sheet(isPresented: $isPresented) {
                FormularioView()
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


struct FormularioView: View {
    @State private var nombre = ""
    @State private var email = ""

    var body: some View {
        Form {
            TextField("Nombre", text: $nombre)
            TextField("Email", text: $email)
            Button("Enviar") {
                // Acción al enviar el formulario
            }
        }
    }
}

#Preview {
    BudgetsView()
}
