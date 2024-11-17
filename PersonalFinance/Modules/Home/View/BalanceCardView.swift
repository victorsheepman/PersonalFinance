//
//  BalanceCardView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI
import SwiftData

struct BalanceCardView: View {
    @Query var transactions: [Transaction]
    
    var title: String
    var account: TransactionAccount
        
    private var amount: String {
        let balance = calculateAmount()
        return String(balance)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(Color("Grey-500"))
            Text("$\(amount)")
                .font(.system(size: 32))
                .bold()
                .foregroundStyle(Color("Grey-900"))
        }
        .frame(height: 70)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    private func calculateAmount() -> Double {
        let income = transactions
            .filter { $0.account == account && $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = transactions
            .filter { $0.account == account && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        return income - expense
    }
}

