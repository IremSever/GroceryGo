//
//  ButtonPay.swift
//  GroceryGo
//
//  Created by İrem Sever on 30.01.2024.
//

import SwiftUI

struct ButtonPay: View {
    var payNowAction: () -> Void
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            payNowAction()
        }) {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
                .frame(width: 120, height: 60)
                .foregroundColor(.white)
                .background(.green)
                .bold()
            Text("Pay Now")
                .foregroundColor(.white)
                .font(.system(size: 25, weight: .bold))
                .offset(x: -118)
        }.offset(x: 150, y: -45)
    }
}

struct ButtonPay_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPay(payNowAction: {})
    }
}
