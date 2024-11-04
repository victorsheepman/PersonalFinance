//
//  ContentView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var indice = 0
    
    @State private var tabSelected: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    
    var body: some View {
        ZStack {
            
            VStack {
                TabView(selection: $tabSelected) {
                    
                    HomeView()
                        .tag(Tab.house)
                    
                    BudgetsView()
                        .tag(Tab.chart)
                    
                    TransactionView()
                        .tag(Tab.transaction)
                    
                }
                
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $tabSelected)
            }
        }
    }
}



#Preview {
    ContentView()
}
