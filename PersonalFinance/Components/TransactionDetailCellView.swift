//
//  TransactionDetailCellView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI

struct TransactionDetailCell: View {
    
    var sender: String
    var amount: Double
    var date: Date
    var category: String?
    
    var body: some View{
        HStack{
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding(.trailing, 10)
            VStack(alignment: .leading){
                Text(sender)
                    .font(.headline)
                if let category = category {
                    Text(category)
                        .font(.system(size: 12))
                        .foregroundStyle(Color("Grey-500"))
                }
                
            }
            Spacer()
            VStack{
                Text("\(amount >= 0 ? "+" : "-")$\(abs(amount), specifier: "%.2f")")
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(amount >= 0 ? Color("Green") : Color("Red"))
                
                Text(formatDate(date))
                    .font(.system(size: 12))
                    .foregroundStyle(Color("Grey-500"))
            }
        }
    }
    
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy" // Formato deseado: "19 Aug 2024"
        return formatter.string(from: date)
    }
}


