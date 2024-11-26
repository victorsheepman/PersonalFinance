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
    
    
    @State private var isPresentingBudgetForm: Bool = false
    @State private var isShowingBudgetLimitAlert: Bool = false
    
    var canAddMoreBudgets: Bool {
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
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        handleAddButtonTap()
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                    }
                }
            }
            .alert(isPresented: $isShowingBudgetLimitAlert) {
                Alert(
                    title: Text("Budget Limit Reached"),
                    message: Text("You cannot add more than 4 budgets."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $isPresentingBudgetForm) {
                BudgetForm()
            }
        }
    }
    
    private func handleAddButtonTap() {
        if canAddMoreBudgets {
            isPresentingBudgetForm = true
        } else {
            isShowingBudgetLimitAlert = true 
        }
    }
    
    
}

#Preview {
    BudgetsView()
        .modelContainer(Budget.preview)
}

