//
//  TransactionView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 24/10/24.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack {
                        List(mockTransactions) { t in
                            TransactionDetailCell(sender: t.sender, amount: t.amount, date: t.date)
                                .padding(.top, 12)
                                
                        }.listStyle(.inset)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                    
                    Spacer()

                }.padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text("Transactions")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        Spacer()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("print")
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20)) // Ajusta el tamaño del icono
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Centrar el icono
                            .padding(.trailing, 5)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color("Grey-900"))
                    .clipShape(Circle()) // Forma circular
                    .padding(.top)


                }
            }
        }
     
    }
}

#Preview {
    TransactionView()
}
