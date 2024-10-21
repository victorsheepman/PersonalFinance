//
//  HomeView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        
                        
                        BalanceCardView(title: "Current Balance", balance: "4,836.00", isDark: true)
                        BalanceCardView(title: "Income", balance: "3,814.25")
                        BalanceCardView(title: "Expenses", balance: "1,700.50")
                        
                        
                    }
                    .padding()
                }.navigationTitle("Overview")
                
            }
        }
        
    }
}

#Preview {
    HomeView()
}
