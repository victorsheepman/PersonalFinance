//
//  BudgetsView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI
import SwiftData

struct BudgetsView: View {
    
    @Query(sort: \Budget.id) var budgets: [Budget]
    
    @State private var isPresented: Bool = false
    @State private var showAlert: Bool = false
    
    @StateObject private var viewModel: BudgetViewModel = BudgetViewModel()
    
    var totalBudgets: Bool {
        budgets.count < 4
    }
 
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack {
                        BudgetSectionView()
                        ForEach(budgets) { budget in
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
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if totalBudgets {
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
                BudgetForm(isPresented: $isPresented, viewModel: viewModel)
            }
        }
    }
}





#Preview {
    BudgetsView()
        .modelContainer(Budget.preview)
}

