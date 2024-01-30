//
//  CartManager.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//


import Foundation

class CartManager: ObservableObject {

    @Published var products: [Products] = []
    @Published private(set) var total: Float = 0
    @Published private(set) var amount: Int = 0
    @Published public var cartItems: [CartItem] = []
    
    struct CartItem {
        var product: Products
        var quantity: Int
        var stock: Int
    }
    
    func fetchProducts() async throws {
        let url = URL.allProducts
        let (data, response) = try await URLSession.shared.data(from: url)

        print("Response Status Code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
        print(String(data: data, encoding: .utf8) ?? "Invalid data")

        let decodedData = try JSONDecoder().decode(RootClass.self, from: data)
        products = decodedData.data
    }

    func addToCart(product: Products) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            if cartItems[index].quantity < cartItems[index].stock {
                cartItems[index].quantity += 1
                total += product.price
                amount += 1
                if let productIndex = products.firstIndex(where: { $0.id == product.id }) {
                    products[productIndex].stock -= 1
                }
            } else {
                print("Stock limit reached for \(product.name)")
            }
        } else {
            if product.stock > 0 {
                cartItems.append(CartItem(product: product, quantity: 1, stock: product.stock))
                total += product.price
                amount += 1
                if let productIndex = products.firstIndex(where: { $0.id == product.id }) {
                    products[productIndex].stock -= 1
                }
            } else {
                print("\(product.name) is out of stock")
            }
        }
    }

    
    func removeFromCart(product: Products) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity -= 1
            if cartItems[index].quantity == 0 {
                cartItems.remove(at: index)
            }
            total -= product.price
            amount -= 1
            
            if let productIndex = products.firstIndex(where: { $0.id == product.id }) {
                products[productIndex].stock += 1
            }
        }
    }



    func cartItemCount(for product: Products) -> Int {
        cartItems.first { $0.product.id == product.id }?.quantity ?? 0
    }
}
