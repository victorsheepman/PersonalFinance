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
            Color("#F2F3F7").edgesIgnoringSafeArea(.all)
            VStack {
                TabView(selection: $tabSelected) {
                    
                    HomeView()
                        .tag(Tab.house)
                    
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
