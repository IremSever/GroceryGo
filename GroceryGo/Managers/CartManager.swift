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
    @Published private(set) var total: Double = 0
    
    func fetchProduct() async throws {
        let url = URL.allProducts
        let (data, response) = try await URLSession.shared.data(from: url)

        print("Response Status Code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
        print(String(data: data, encoding: .utf8) ?? "Invalid data")

        let decodedData = try JSONDecoder().decode(RootClass.self, from: data)
        products = decodedData.data
    }
    
    func addToCart(product: Products) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: Products) {
        if let index = products.firstIndex(of: product) {
            products.remove(at: index)
            total -= product.price
        }
    }
}

