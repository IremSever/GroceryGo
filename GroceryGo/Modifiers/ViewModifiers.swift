//
//  ViewModifiers.swift
//  GroceryGo
//
//  Created by İrem Sever on 23.01.2024.
//

import Foundation
import SwiftUI

struct ViewModifiers: ViewModifier {
    
    private var backgroundColor: Color
    private var foregroundColor: Color
    
    init(backgroundColor: Color = Color.green, foregroundColor: Color = Color.white) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    func body(content: Content) -> some View {
        content.padding(5)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .background {
                backgroundColor
            }
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
    
}
