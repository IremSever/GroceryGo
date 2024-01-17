//
//  OrderConfirmationResponse.swift
//  GroceryGo
//
//  Created by İrem Sever on 16.01.2024.
//

import Foundation
struct OrderConfirmationResponse: Codable {
       let meta: Meta
       let data: ConfirmationData
   }

   struct Meta: Codable {
       let status_code: Int
       let description: String
   }

   struct ConfirmationData: Codable {
       let status: Bool
       let message: String
   }
