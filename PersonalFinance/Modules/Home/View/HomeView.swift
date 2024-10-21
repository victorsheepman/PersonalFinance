//
//  HomeView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import SwiftUI




struct HomeView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        
                        
                        BalanceCardView(title: "Current Balance", balance: "4,836.00", isDark: true)
                        BalanceCardView(title: "Income", balance: "3,814.25")
                        BalanceCardView(title: "Expenses", balance: "1,700.50")
                        
                        VStack(alignment: .leading, spacing: 12) {
                            NavigationLink(value:"Transaction") {
                                HStack{
                                    Text("Transactions")
                                        .font(.system(size: 20))
                                        .bold()
                                        .foregroundStyle(Color("Grey-900"))
                                    Spacer()
                                    Label("View All", systemImage:"arrowtriangle.forward.fill")
                                        .labelStyle(RightIconLabelStyle())
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color("Grey-500"))
                                  
                                }
                                
                              
                               
                            }.foregroundColor(.secondary)
                             .padding(.bottom, 12)
                            ForEach(mockTransactions, id: \.id) { t in
                                   TransactionDetailCell(sender: t.sender)
                                       .listRowSeparator(.hidden, edges: .all)
                                       .padding(.vertical, 2)
                                if t.id != mockTransactions.last?.id {
                                               Divider()
                                                   .background(Color("Grey-100")) 
                                                   
                                           }
                               }
                               
                         
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                        
                    }
                    .padding()
                }.navigationTitle("Overview")
                
            }
        }
        
    }
}

struct RightIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title // Texto a la izquierda
            configuration.icon // Ícono a la derecha
        }
    }
}

struct TransactionDetailCell: View {
    var sender: String
    var body: some View{
        HStack{
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding(.trailing, 10)
            Text(sender)
                .font(.headline)
            Spacer()
            VStack{
                Text("+$75.50")
                    .font(.system(size: 14))
                    .bold()
                    .foregroundStyle(Color("Green"))

                Text("19 Aug 2024")
                    .font(.system(size: 12))
                    .foregroundStyle(Color("Grey-500"))
            }
        }
    }
}

#Preview {
    HomeView()
}
