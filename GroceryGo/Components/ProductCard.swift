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
        // Pictures
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.green)
                .opacity(0.25)
                .frame(width: 90, height: 90)
            
            AsyncImage(url: URL(string: product.imageUrl)) { image in image
                    .resizable()
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                    .shadow(radius: 5)
            } placeholder: {
                Color.gray
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                    .shadow(radius: 5)
            }

            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Text("₺\(product.price)")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(product.name)
                        .font(.caption).bold()
                        .frame(maxWidth: .infinity, alignment: .bottom)
                    
                    Text("Stock: \(product.stock)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
                .frame(width: 120, height: 60)
                .cornerRadius(5)
                .offset(y: 75)
                Spacer()
            }
        }
        .overlay(
            Image(systemName: "plus")
                .padding(9)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(50)
                .offset(x: 45, y: -40)
                .padding()
                .onTapGesture {
                    cartManager.addToCart(product: product)
                }
        )
        .frame(width: 90, height: 90)
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        ProductCard(product: Products.preview)
            .environmentObject(cartManager)
    }
}
