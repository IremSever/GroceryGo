//
//  ProductRow.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Products

    @State private var offset: CGFloat = 0
    @State private var isTrashVisible = false

    private var productCountInCart: Int {
        cartManager.products.filter { $0.id == product.id }.count
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name).bold()
                Text("₺\(product.price)")
            }
            Spacer()
            
        
            //amount
            ZStack{
                RoundedRectangle(cornerRadius: 1)
                    .strokeBorder()
                    .frame(width:40, height: 24)
                    .foregroundColor(.green)
                    .bold()
                    .padding(.trailing, 45)
                Text("\(productCountInCart)")
                    .foregroundColor(.black)
                    .padding(.trailing, 45)
                
                
                Image(systemName: "amount")
                    .padding(3)
                
                Image(systemName: "plus")
                    .padding(3)
                    .foregroundColor(.white).bold()
                    .background(Color.green)
                    .offset(x: 12, y: -30.6)
                    .padding()
                    .onTapGesture {
                        cartManager.addToCart(product: product)
                    }.offset(x:-3, y:31)
                
                Image(systemName: "minus")
                    .padding(3)
                    .foregroundColor(.white).bold()
                    .background(Color.green)
                    .offset(x: -50, y: -30.6)
                    .padding()
                    .onTapGesture {
                        cartManager.removeFromCart(product: product)
                    }.offset(x:-3, y:31)
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
        .offset(x: offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation.width
                    self.isTrashVisible = self.offset < 0
                }
                .onEnded { value in
                    if self.offset < -50 {
                        self.offset = -2500
                        cartManager.removeFromCart(product: product)
                    } else {
                        self.offset = 0
                        self.isTrashVisible = false
                    }
                }
        )
    }
}
   struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productList[3])
            .environmentObject(CartManager())
    }
}
