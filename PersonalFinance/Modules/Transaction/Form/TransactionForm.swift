//
//  TransactionForm.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import SwiftUI

struct TransactionForm: View {
    @State private var title: String = ""
    @State private var amount: String = ""
    var body: some View {
        Form {
            TextField("Title", text: $title)
            
            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .disableAutocorrection(true)
        }
    }
}

#Preview {
    TransactionForm()
}
