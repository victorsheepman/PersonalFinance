//
//  TransactionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 24/10/24.
//

import SwiftUI

struct TransactionView: View {
    
    @Environment(BudgetViewModel.self) var viewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    List {
                        ForEach(viewModel.transactions) { t in
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
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text("Transactions")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        Spacer()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            viewModel.addTransaction(
                                to: viewModel.budgets.first ?? nil ,
                                title: "Pago",
                                amount: 25.0,
                                date: Date(),
                                type: .income
                            )
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) 
                            .padding(.trailing, 4)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color("Grey-900"))
                    .clipShape(Circle())
                    .padding(.top)
                }
            }
        }.onAppear {
            viewModel.getTransactions()
        }
        
    }
    
}



#Preview {
    TransactionView()
}
