//
//  BalanceCardView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI

struct BalanceCardView: View {
    
    var title: String
    var balance: String
    var isDark: Bool = false
    
    private var titleColor: Color {
        isDark ? .white : Color("Grey-900")
    }
    
    
    private var captionColor: Color {
        isDark ? .white : Color("Grey-500")
    }
    
    private var backgroundColor: Color {
        isDark ? Color("Grey-900") : .white
      }

    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(captionColor)
            Text("$\(balance)")
                .font(.system(size: 32))
                .bold()
                .foregroundStyle(titleColor)
        }
        .frame(height: 70)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(backgroundColor))
    }
}

#Preview {
    BalanceCardView(title: "Current Balance", balance: "4,836.00", isDark: false)
}
