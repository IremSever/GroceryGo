//
//  OrderView.swift
//  GroceryGo
//
//  Created by İrem Sever on 30.01.2024.
//

import SwiftUI

struct OrderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToContentView = false
    
    private var orderImage: some View {
        Image("order")
            .resizable()
            .scaledToFit()
            .frame(width: 1000, height: 850)
    }
    
    private var thanxText: some View {
        Text("Thank You For Your Order!")
            .font(.system(size: 31, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
            .foregroundColor(.orange)
            .offset(y: -300)
    }

    var body: some View {
        VStack(spacing: 30) {
            
            orderImage
            
            thanxText
   

            Button("Back Home") {
                navigateToContentView = true
            }
            .frame(width: 150, height: 50)
            .font(.system(size: 20))
            .foregroundColor(.white)
            .background(.green)
            .bold()
            .cornerRadius(10)
            .offset(y: -200)
            .fullScreenCover(isPresented: $navigateToContentView) {
                ContentView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}

