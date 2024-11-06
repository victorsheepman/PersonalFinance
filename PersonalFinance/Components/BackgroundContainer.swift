//
//  BackgroundContainer.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 5/11/24.
//

import SwiftUI

struct BackgroundContainer<Content: View>: View {
    
    @Binding var isPresented: Bool
    
    let title: String
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                content()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                   
                }
            }

        }
    }
}

#Preview {
    BackgroundContainer(isPresented: .constant(false), title: "Transaction"){
        Text("chart")
            .frame(minHeight: 150)
    }
}
