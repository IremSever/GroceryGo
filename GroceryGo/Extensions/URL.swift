//
//  URL.swift
//  GroceryGo
//
//  Created by İrem Sever on 23.01.2024.
//

import Foundation
extension URL {
    
    static var development: URL {
        URL(string: "https://i.tmgrup.com.tr/mulakat/get-liste.json")!
    }
    
    static var production: URL {
        URL(string: "https://i.tmgrup.com.tr/mulakat/get-liste.json")!
    }
    
    static var `default`: URL {
        #if DEBUG
            return development
        #else
            return production
        #endif
    }
    
    static var allProducts: URL {
        URL(string: "https://i.tmgrup.com.tr/mulakat/get-liste.json")!
    }
    
    static var postPayment: URL {
        URL(string: "https://i.tmgrup.com.tr/mulakat/post-onay.json")!
    }
    
}
