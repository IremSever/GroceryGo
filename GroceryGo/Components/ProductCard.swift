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
        
        //Pictures
        ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.green)
                    .opacity(0.25)
                    .frame(width: 90, height: 90)

                ZStack(alignment: .topTrailing) {
                    ZStack(alignment: .bottom) {
                        Image(product.image)
                            .resizable()
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
                        
                        .shadow(radius: 5)

                        VStack {
                            Spacer()
                            VStack(alignment: .leading, spacing: 3) {
                                Text("₺\(product.price)")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text(product.name)
                                    .font(.caption).bold()
                                    .frame(maxWidth: .infinity, alignment: .bottom)
                            }
                            .padding()
                            .frame(width: 120, height: 40)
                            .cornerRadius(5)
                            .offset(y: 67)
                            Spacer()
                        }
                    }

                    // add
                    Image(systemName: "plus")
                        .padding(7)
                        .foregroundColor(.white).bold()
                        .background(Color.green)
                        .cornerRadius(50)
                        .offset(x: 13, y: -32)
                        .padding()
                        .onTapGesture {
                            cartManager.addToCart(product: product)
                        }
                }
                .frame(width: 90, height: 90)
            }
  }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: productList[0])
            .environmentObject(CartManager())
    }
}
