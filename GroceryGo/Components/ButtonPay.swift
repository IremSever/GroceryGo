//
//  ButtonPay.swift
//  GroceryGo
//
//  Created by İrem Sever on 30.01.2024.
//

import SwiftUI

struct ButtonPay: View {
    var payNowAction: () -> Void

        var body: some View {
            Button(action: {
                payNowAction()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder()
                        .frame(width: 120, height: 60)
                        .foregroundColor(.white)
                        .background(.green)
                        .bold()
                    Text("Pay Now")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold))
                }.offset(x: 80, y: -45)
                  
            }
        }
    }

struct ButtonPay_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPay(payNowAction: {})
    }
}
