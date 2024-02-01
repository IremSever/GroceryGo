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
    @State var changeScreen = false
    @Environment(\.presentationMode) var presentationMode

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
                        Text("Your cart is empty")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                            .offset(y: 200)
                    }
                }

                if cartManager.cartItems.count > 0 {
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
                                    Text("₺\(String(format: "%.2f", cartManager.total))")
                                        .font(.system(size: 26, weight: .bold))
                                        .foregroundColor(Color.white)
                                        .frame(width: 350, alignment: .leading)
                                        .padding(.leading, 60)
                                }
                            )
                            .padding()
                    }
                    .padding(.bottom, -60)

                    ButtonPay(payNowAction: {
                        Task {
                            do {
                                try await cartManager.payNow()
                            } catch {
                                print("Error while paying: \(error)")
                            }
                        }
                    }, changeScreen: $changeScreen)
                }
            }
            .padding(.top)
            .navigationTitle("My Cart")
            
            //back to ShopView()
            /*.navigationBarItems(leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.green)
                }
            )*/
            
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $changeScreen) {
            OrderView()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}




