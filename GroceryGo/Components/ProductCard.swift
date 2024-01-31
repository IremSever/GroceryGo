//
//  ProductCard.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//


import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Products

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image
                    .resizable()
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .shadow(radius: 5)
            } placeholder: {
                Color.gray
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .shadow(radius: 5)
            }

            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Text(formatPrice(product.price))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text(product.name)
                        .font(.system(size: 9))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .bottom)
                    if product.stock > 0 {
                        Text("Stock: \(product.stock)")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .bottom)
                            .foregroundColor(.gray)
                    } else {
                        Text("Out of Stock")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .bottom)
                            .foregroundColor(.red)
                    }
                        
                    
                }
                .padding()
                .frame(width: 105, height: 80)
                .cornerRadius(5)
                .offset(y: 80)
                Spacer()
            }
        }
        .overlay(
            Image(systemName: "plus")
                .padding(8)
                .foregroundColor(.white)
                .background(product.stock > 0 ? Color.green : Color.gray.opacity(0.7)) 
                .cornerRadius(50)
                .offset(x: 45, y: -45)
                .padding()
                .onTapGesture {
                    if product.stock > 0 {
                        cartManager.addToCart(product: product)
                        var updatedProduct = product
                        updatedProduct.stock -= 1
                    } else {
                        print("\(product.name) is out of stock")
                    }
                }
        )
        .frame(width: 100, height: 100)
    }

    // price as float
    private func formatPrice(_ price: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₺"
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        ProductCard(product: Products.preview)
            .environmentObject(cartManager)
    }
}


