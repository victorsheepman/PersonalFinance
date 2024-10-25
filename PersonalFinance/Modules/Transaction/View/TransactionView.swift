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
                    List(viewModel.transactions) {
                        Text($0.title)
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
                                title: "Bravo Zen Spa",
                                amount: 25.0,
                                date: Date(),
                                type: .expense
                            )
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20)) // Ajusta el tamaño del icono
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Centrar el icono
                            .padding(.trailing, 5)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color("Grey-900"))
                    .clipShape(Circle()) // Forma circular
                    .padding(.top)
                    
                    
                }
            }
        }.onAppear {
            viewModel.getTransactions()
        }
        
    }
    
}
private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy" // Formato deseado: "19 Aug 2024"
    return formatter.string(from: date)
}


#Preview {
    TransactionView()
}
