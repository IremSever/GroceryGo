//
//  CartManager.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import Foundation

class CartManager: ObservableObject{
    @Published private(set) var products: [Products] = []
    @Published private(set) var total: Int = 0
    
    

    func addToCart(product: Products) {
        products.append(product)
        total += product.price
    }

    func removeFromCart(product: Products) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            total -= products[index].price
            products.remove(at: index)
        }
    }
}
 
