//
//  CartManager.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import Foundation

class CartManager: ObservableObject {
    
    let client = StoreHTTPClient()
    @Published var products: [Products] = []
    @Published var productsInCart: [Products] = []
    @Published private(set) var total: Float = 0
    @Published private(set) var amount: Int = 0
       
    func fetchProduct() async throws {
        let url = URL.allProducts
        let (data, response) = try await URLSession.shared.data(from: url)

        print("Response Status Code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
        print(String(data: data, encoding: .utf8) ?? "Invalid data")

        let decodedData = try JSONDecoder().decode(RootClass.self, from: data)
        products = decodedData.data
    }
       
    func addToCart(product: Products) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            if products[index].stock > 0 {
                products[index].stock -= 1
                total += product.price
                productsInCart.append(product)
                amount += 1
            }
        }
    }
        
    func removeFromCart(product: Products) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].stock += 1
            total -= product.price
            if products[index].stock == 0 {
                products.remove(at: index)
            }
        }
        if let index = productsInCart.firstIndex(of: product) {
            productsInCart.remove(at: index)
            amount -= 1
        }
    }
}
