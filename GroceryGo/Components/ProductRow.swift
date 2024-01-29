//
//  ProductRow.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    public let product: Products

    @State private var isTrashVisible = false

    private var productCountInCart: Int {
        cartManager.cartItemCount(for: product)
    }

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name).bold()
                Text(formatPrice(product.price))
            }
            Spacer()

            Text("\(productCountInCart)")
                .foregroundColor(.white)
                .frame(width: 40, height: 24)
                .background(Color.green)
                .cornerRadius(5)
                .offset(x: 4)

            HStack {
                Button(action: {
                    cartManager.addToCart(product: product)
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.red)
                        .cornerRadius(5)
                        .offset(x: -1)
                }

                Button(action: {
                    cartManager.removeFromCart(product: product)
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                        .padding(7)
                        .background(Color.red)
                        .cornerRadius(5)
                }
                .offset(x: -115)
            }

            if isTrashVisible {
                Image(systemName: "trash")
                    .foregroundColor(Color(hue: 1.0, saturation: 0.9, brightness: 0.85))
                    .onTapGesture {
                        cartManager.removeFromCart(product: product)
                    }
                    .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }

    private func formatPrice(_ price: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₺"
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        ProductRow(product: Products.preview)
            .environmentObject(cartManager)
    }
}
