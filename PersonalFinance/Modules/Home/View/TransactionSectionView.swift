//
//  TransactionSectionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 9/11/24.
//

import SwiftUI


struct TransactionSectionView: View {
    let transactions: [Transaction]
   
    private var lastTransactionID: UUID? {
        transactions.last?.id
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transactions")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(Color("Grey-900"))
            
            ForEach(transactions, id: \.id) { transaction in
                TransactionCellView(transaccion: transaction)
                
                if transaction.id != lastTransactionID {
                    Divider()
                        .background(Color("Grey-100"))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
}

