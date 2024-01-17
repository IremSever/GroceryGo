//
//  ShopView.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

struct ShopView: View {
    @StateObject var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 90), spacing: 12)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30){
                    ForEach(productList, id: \.id) { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                    }
                    .padding()
                }
                .navigationTitle(Text("Grocery Go"))
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                NavigationLink{
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    ButtonCart(numberOfProducts: cartManager.products.count)
                }
            }
        }
    }
    
    struct ShopView_Previews: PreviewProvider {
        static var previews: some View {
            ShopView()
                .environmentObject(CartManager())
        }
    }
}
