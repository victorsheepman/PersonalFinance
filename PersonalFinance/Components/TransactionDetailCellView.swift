//
//  TransactionDetailCellView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI

struct TransactionCellView: View {
    var transaccion: Transaction
    
    private var amountSymbol: String {
        transaccion.type == .income ? "+" : "-"
    }
    
    private var transactionColor: Color {
        transaccion.type == .income ? Color("Green") : .red
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaccion.title)
                    .accessibilityLabel("Transaction Title")
                Text(transaccion.budget?.category.rawValue ?? "General")
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack {
                Text("\(amountSymbol)\(transaccion.amount, specifier: "%.2f")$")
                    .foregroundColor(transactionColor)
                
                Text(transaccion.date.formattedAsString())
                    .accessibilityLabel("Transaction Date")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
        }
    }
}


