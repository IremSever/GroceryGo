//
//  Products.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import Foundation

struct Products: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [Products(name: "Tomato", image: "1-tomato", price: 10),
                   Products(name: "Cucumber", image: "2-cucumber", price: 10),
                   Products(name: "Potato", image: "3-potato", price: 10),
                   Products(name: "Coke", image: "4-coke", price: 10),
                   Products(name: "Wafer", image: "5-wafer", price: 2),
                   Products(name: "Bread", image: "6-bread", price: 10),
                   Products(name: "Mushroom", image: "7-mushroom", price: 20),
                   Products(name: "Icecream", image: "8-icecream", price: 10),
                   Products(name: "water", image: "9-water", price: 10)]
