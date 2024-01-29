//
//  SwiftUIView.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var isPayment = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if cartManager.cartItems.count > 0 {
                        ForEach(cartManager.cartItems, id: \.product.id) { cartItem in
                            ProductRow(product: cartItem.product)
                                .padding()
                        }
                    } else {
                        Text("Your cart is Empty")
                    }
                }

                if cartManager.cartItems.count > 0 { // Check if cart is not empty
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green)
                            .frame(width: 350, height: 100)
                            .overlay(
                                VStack {
                                    Text("Total Price")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.white)
                                        .frame(width: 350, alignment: .leading)
                                        .padding(.leading, 60)
                                    Text("₺\(String(cartManager.total))")
                                        .font(.system(size: 26, weight: .bold))
                                        .foregroundColor(Color.white)
                                        .frame(width: 350, alignment: .leading)
                                        .padding(.leading, 60)
                                }
                            )
                            .padding()
                    }
                    .padding(.bottom, -60)

                    Button() {
                        isPayment = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder()
                                .frame(width: 120, height: 60)
                                .foregroundColor(.white)
                                .bold()
                            Text("Pay Now")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .bold))
                        }.offset(x: 80, y: -45)
                    }
                }
            }
            .navigationTitle("My Cart")
            .padding(.top)
        }
    }
}

    struct CartView_Previews: PreviewProvider {
        static var previews: some View {
            CartView()
                .environmentObject(CartManager())
        }
    }

