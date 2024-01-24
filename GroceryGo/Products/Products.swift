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

extension Products {
    static var preview: Products {
        Products(id: "5f52348e919ff34aed98d349", name: "Elma", price: 6.99, currency: "₺", imageUrl: "https://desolate-shelf-18786.herokuapp.com/images/elma.png", stock: 5)
    }
}
struct Meta: Codable {
    let statusCode: Int
    let description: String
}

struct RootClass: Codable {
    let meta: Meta
    let data: [Products]

    private enum CodingKeys: String, CodingKey {
        case meta, data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Handle the decoding of "meta" section
        do {
            meta = try container.decode(Meta.self, forKey: .meta)
        } catch {
            // If "statusCode" key is not found, provide a default value
            meta = Meta(statusCode: 200, description: "")
        }

        // Decode the "data" section
        data = try container.decode([Products].self, forKey: .data)
    }
}
