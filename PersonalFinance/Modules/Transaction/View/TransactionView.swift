//
//  TransactionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 24/10/24.
//

import SwiftUI

struct TransactionView: View {
    
    @StateObject var viewModel: TransactionViewModel = TransactionViewModel()
    
    @State private var isPresented: Bool = false
    
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
                        }.onDelete(perform: viewModel.removeTransaction)
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
                        isPresented = true
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
            .sheet(isPresented: $isPresented) {
                VStack{
                    HStack(spacing:95) {
                        Text("Add New Budget")
                            .font(.title)
                            .bold()
                        
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color("Grey-500"))
                        }
                    }
                    TransactionForm(viewModel: viewModel, isPresented: $isPresented)
                    
                   
                    
                }
                .padding()
                
            }
        }.onAppear {
            viewModel.getTransactions()
        }
        
    }
    
}



#Preview {
    TransactionView()
}
