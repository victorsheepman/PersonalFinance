//
//  BudgetsView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI

struct BudgetsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
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
}

#Preview {
    BudgetsView()
}
