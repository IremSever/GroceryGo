//
//  View.swift
//  GroceryGo
//
//  Created by İrem Sever on 23.01.2024.
//

import Foundation
import SwiftUI

extension View {
    
    func borderedCaption(backgroundColor: Color = .green, foregroundColor: Color = .white) -> some View {
        modifier(ViewModifiers(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
    
}
