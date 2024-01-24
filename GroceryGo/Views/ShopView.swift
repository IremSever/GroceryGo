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
        
    var columns = [GridItem(.adaptive(minimum: 120), spacing: 12)] // Adjusted width for ProductCard
        
    var body: some View {
        NavigationView {
            ScrollView {
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
                    LazyVGrid(columns: columns, spacing: 16) { // Adjusted spacing for ProductCard
                        ForEach(cartManager.products, id: \.id) { product in
                            NavigationLink(destination: ProductCard(product: product).environmentObject(cartManager)) {
                                ProductCard(product: product)
                                    .environmentObject(cartManager)
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Grocery Go"))
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                NavigationLink(destination: CartView().environmentObject(cartManager)) {
                    ButtonCart(numberOfProducts: cartManager.products.count)
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
