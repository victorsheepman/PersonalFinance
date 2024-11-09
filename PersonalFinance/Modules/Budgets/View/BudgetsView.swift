//
//  BudgetsView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI

struct BudgetsView: View {
    
    @State private var isPresented: Bool = false
    @State private var showAlert: Bool = false
    
    @StateObject private var viewModel: BudgetViewModel = BudgetViewModel()
 
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack {
                        BudgetSectionView(budgets: viewModel.budgets)
                        ForEach(viewModel.budgets) { budget in
                            BudgetsCard(budget: budget, viewModel: viewModel)
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
                    Text("Budgets")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if viewModel.budgets.count < 4 {
                            isPresented = true
                        } else {
                            showAlert = true
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Budget Limit Reached"),
                    message: Text("You cannot add more than 4 budgets."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $isPresented) {
                VStack{
                    formHeader
                    BudgetForm(isPresented: $isPresented, viewModel: viewModel)
                }
                .padding()
                .background(Color("Background"))
            }
        }
        .onAppear() {
            viewModel.fetchBudgets()
        }
    }
    
    var formHeader: some View {
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
    }
}





#Preview {
    BudgetsView()
}

