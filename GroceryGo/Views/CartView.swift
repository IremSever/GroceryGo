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

                    ButtonPay(payNowAction: payNow).navigationDestination(isPresented: $changeScreen) {
                        OrderView()
                    }
                }
            }
            .padding(.top, 15) 
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("My Cart")
        }
    }
}

private func payNow() {
    guard let url = URL(string: "https://i.tmgrup.com.tr/mulakat/post-onay.json") else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }

        if let response = response as? HTTPURLResponse {
            print("Response status code: \(response.statusCode)")
        }

        if let data = data {
            print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
        }
    }.resume()
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}



