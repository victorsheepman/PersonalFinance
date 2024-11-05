//
//  TransactionDetailCellView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI

struct TransactionCellView: View {
    var transaccion: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaccion.title)
                Text(transaccion.budget?.category.rawValue ?? "General")
                    .foregroundColor(.gray)
            }
            Spacer()
            
            VStack {
                Text("\(transaccion.type == .income ? "+" : "-")\(transaccion.amount, specifier: "%.2f")$")
                    .foregroundColor(transaccion.type == .income ? Color("Green") : Color("Red"))
                
                Text(transaccion.date.formattedAsString())
                    .font(.system(size: 12))
                    .foregroundStyle(Color("Grey-500"))
                
            }
        }
    }
}


