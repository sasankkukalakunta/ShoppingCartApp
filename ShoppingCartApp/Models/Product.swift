//
//  Product.swift
//  ShoppingCartApp
//
//  Created by kukalakunta sasank on 2/8/25.
//

import Foundation

struct Product: Identifiable, Codable {
    let id = UUID()
    let name: String
    let price: Double
    let imageUrl: String
}
