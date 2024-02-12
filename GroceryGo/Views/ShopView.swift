//
//  ShopView.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//
import SwiftUI

struct ShopView: View {
   
    @StateObject var cartManager = CartManager()
    @State var errorMessage = ""
    @State private var isCartViewPresented = false
        
    var columns = [GridItem(.adaptive(minimum: 120), spacing: 1)]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if cartManager.products.isEmpty {
                        ProgressView("Loading products...")

                    } else {
                        LazyVGrid(columns: columns, spacing: 80) {
                            ForEach(cartManager.products, id: \.id) { product in
                                ProductCard(product: product)
                                    .environmentObject(cartManager)
                            }
                        }
                        .padding(.all, 15)
                    }
                }
            }
            .navigationTitle("Grocery Go")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ButtonCart(cartManager: cartManager)
                    .onTapGesture {
                        isCartViewPresented = true
                    }
            }
            .fullScreenCover(isPresented: $isCartViewPresented) {
                CartView()
                    .environmentObject(cartManager)
            }
            Text(errorMessage)
        }
        .navigationTitle("Grocery Go")
 
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    struct ShopView_Previews: PreviewProvider {
        static var previews: some View {
            ShopView()
                .environmentObject(CartManager())
        }
    }
}


