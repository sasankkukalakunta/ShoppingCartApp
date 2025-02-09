//
//  ShoppingCartViewModel.swift
//  ShoppingCartApp
//
//  Created by kukalakunta sasank on 2/8/25.
//

import Foundation

class ShoppingCartViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(name: "Apple", price: 1.0, imageUrl: "https://via.placeholder.com/100x100?text=Apple"),
        Product(name: "Banana", price: 0.5, imageUrl: "https://via.placeholder.com/100x100?text=Banana"),
        Product(name: "Orange", price: 0.8, imageUrl: "https://via.placeholder.com/100x100?text=Orange"),
        Product(name: "Grapes", price: 2.5, imageUrl: "https://via.placeholder.com/100x100?text=Grapes")
    ]
    
    @Published var cart: [CartItem] = [] {
        didSet {
            saveCartToUserDefaults()
        }
    }
    
    @Published var searchQuery: String = "" // For product search

    var filteredProducts: [Product] {
        if searchQuery.isEmpty {
            return products
        } else {
            return products.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    var totalCost: Double {
        cart.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    init() {
        loadCartFromUserDefaults()
    }
    
    func addToCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func updateCartQuantity(cartItem: CartItem, increase: Bool) {
        if let index = cart.firstIndex(where: { $0.id == cartItem.id }) {
            if increase {
                cart[index].quantity += 1
            } else if cart[index].quantity > 1 {
                cart[index].quantity -= 1
            } else {
                cart.remove(at: index)
            }
        }
    }
    
    func clearCart() {
        cart.removeAll()
    }
    
    // MARK: - Persistence with UserDefaults
    private func saveCartToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(cart) {
            UserDefaults.standard.set(encodedData, forKey: "shoppingCart")
        }
    }
    
    private func loadCartFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: "shoppingCart"),
           let decodedCart = try? JSONDecoder().decode([CartItem].self, from: savedData) {
            cart = decodedCart
        }
    }
}
