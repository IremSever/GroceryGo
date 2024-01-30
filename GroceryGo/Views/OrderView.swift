//
//  OrderView.swift
//  GroceryGo
//
//  Created by İrem Sever on 30.01.2024.
//

import SwiftUI

struct OrderView: View {
    @State var changeScreen = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                Image("order")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1000, height: 850)
                Text("Thank You For Your Order!")
                    .font(.system(size: 31, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.orange)
                    .offset(y:-300)
                Button(){
                    changeScreen = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 50)
                        Text("Back Home")
                            .foregroundColor(.white)
                            .bold()
                    }
                }.frame(width: 150, height: 50)
                    .foregroundColor(.green)
                    .offset(y:-200)
            }
            .navigationDestination(isPresented: $changeScreen) {
                ShopView()
            }
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
