//
//  CartView.swift
//  ShoppingCartApp
//
//  Created by kukalakunta sasank on 2/8/24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ShoppingCartViewModel
    
    var body: some View {
        VStack {
            if viewModel.cart.isEmpty {
                Text("Your cart is empty.")
                    .font(.headline)
                    .padding()
            } else {
                List(viewModel.cart) { cartItem in
                    HStack {
                        // Fixed AsyncImage
                        AsyncImage(url: URL(string: cartItem.product.imageUrl)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            } else if phase.error != nil {
                                // Error placeholder
                                Image(systemName: "xmark.octagon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.red)
                            } else {
                                // Loading spinner
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(cartItem.product.name)
                                .font(.headline)
                            Text("Price: \(String(format: "$%.2f", cartItem.product.price))")
                                .font(.subheadline)
                            Text("Quantity: \(cartItem.quantity)")
                                .font(.subheadline)
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                viewModel.updateCartQuantity(cartItem: cartItem, increase: false)
                            }) {
                                Text("-")
                                    .font(.headline)
                                    .frame(width: 30, height: 30)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                            Button(action: {
                                viewModel.updateCartQuantity(cartItem: cartItem, increase: true)
                            }) {
                                Text("+")
                                    .font(.headline)
                                    .frame(width: 30, height: 30)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                
                HStack {
                    Text("Total: \(String(format: "$%.2f", viewModel.totalCost))")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        viewModel.clearCart()
                    }) {
                        Text("Clear Cart")
                            .font(.caption)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}
