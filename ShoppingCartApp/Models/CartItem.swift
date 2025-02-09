//
//  CartItem.swift
//  ShoppingCartApp
//
//  Created by kukalakunta sasank on 2/8/25.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
