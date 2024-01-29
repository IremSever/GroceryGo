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
    
    @State private var stock: Int // Add a local state for stock count
    
    init(product: Products) {
        self.product = product
        self._stock = State(initialValue: product.stock)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.green)
                .opacity(0.25)
                .frame(width: 105, height: 85)

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
                        .font(.caption).bold()
                        .frame(maxWidth: .infinity, alignment: .bottom)

                    Text("Stock: \(stock)")
                        .font(.caption)
                        .foregroundColor(stock > 0 ? .gray : .red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            if stock > 0 {
                                cartManager.addToCart(product: product)
                                stock -= 1
                            }
                        }

                }
                .padding()
                .frame(width: 105, height: 80)
                .cornerRadius(5)
                .offset(y: 85)
                Spacer()
            }
        }
        .overlay(
            Image(systemName: "plus")
                .padding(8)
                .foregroundColor(stock > 0 ? .white : .gray)
                .background(stock > 0 ? Color.green : Color.gray.opacity(0.7))
                .cornerRadius(50)
                .offset(x: 45, y: -40)
                .padding()
                .onTapGesture {
                    if stock > 0 {
                        cartManager.addToCart(product: product)
                        stock -= 1
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


