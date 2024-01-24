//
//  Products.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import Foundation
import SwiftUI

struct Products: Codable, Hashable {
    let id: String
    let name: String
    let price: Double
    let currency: String
    let imageUrl: String
    let stock: Int
}
struct Meta: Codable {
    let statusCode: Int
    let description: String
}

struct RootClass: Codable {
    let meta: Meta
    let data: [Products]
}

extension Products {
    static var preview: Products {
        Products(id: "5f52348e919ff34aed98d349", name: "Elma", price: 6.99, currency: "₺", imageUrl: "https://desolate-shelf-18786.herokuapp.com/images/elma.png", stock: 5)
    }
}
