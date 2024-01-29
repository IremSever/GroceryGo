//
//  ShopView.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

struct ShopView: View {
   
    @StateObject var cartManager = CartManager()
    @State private var isDataLoaded = false
    @State var errorMessage = ""
        
    var columns = [GridItem(.adaptive(minimum: 120), spacing: 12)]
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if !isDataLoaded {
                        ProgressView("Loading products...")
                            .onAppear {
                                Task {
                                    do {
                                        try await cartManager.fetchProduct()
                                        isDataLoaded = true
                                    } catch {
                                        errorMessage = error.localizedDescription
                                    }
                                }
                            }
                    } else if cartManager.products.isEmpty {
                        Text("No products available")
                            .padding()
                    } else {
                        LazyVGrid(columns: columns, spacing: 80) {
                            ForEach(cartManager.products, id: \.id) { product in
                                ProductCard(product: product)
                                    .environmentObject(cartManager)
                            }
                        }
                        .padding(.top, 20) // Ürünlerin biraz daha aşağıdan başlaması için eklenen padding
                    }
                }
            }
            .navigationTitle("Grocery Go")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                NavigationLink(destination: CartView().environmentObject(cartManager)) {
                    ButtonCart(cartManager: cartManager)
                }
            }
            Text(errorMessage)
        }
        .navigationTitle("Grocery Go")
        .onAppear {
            Task {
                do {
                    try await cartManager.fetchProduct()
                    isDataLoaded = true
                } catch {
                    print("Error fetching products: \(error)")
                    errorMessage = error.localizedDescription
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
