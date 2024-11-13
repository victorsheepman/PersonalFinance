//
//  PersonalFinanceApp.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI
import SwiftData

@main
struct PersonalFinanceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ Budget.self,Transaction.self ])
        
    }
}
