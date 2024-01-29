//
//  ButtonCart.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

struct ButtonCart: View {
    
    @ObservedObject var cartManager: CartManager
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top, 20)
            
            if cartManager.amount > 0 {
                Text("\(cartManager.amount)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(Color(hue: 1.0, saturation: 0.9, brightness: 0.85))
                    .cornerRadius(50)
                    .offset(x: 10, y: 10)
            }
        }
    }
}

struct ButtonCart_Previews: PreviewProvider {
    static var previews: some View {
        ButtonCart(cartManager: CartManager())
    }
}
