//
//  ProductListView.swift
//  ShoppingCartApp
//
//  Created by kukalakunta sasank on 2/8/25.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ShoppingCartViewModel
    
    var body: some View {
        VStack {
            // Search Bar
            TextField("Search Products...", text: $viewModel.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if viewModel.filteredProducts.isEmpty {
                Text("No products found.")
                    .font(.headline)
                    .padding()
            } else {
                List(viewModel.filteredProducts) { product in
                    HStack {
                        // Fixed AsyncImage
                        AsyncImage(url: URL(string: product.imageUrl)) { phase in
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
                            Text(product.name)
                                .font(.headline)
                            Text(String(format: "$%.2f", product.price))
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: {
                            viewModel.addToCart(product: product)
                        }) {
                            Text("Add to Cart")
                                .font(.caption)
                                .padding(8)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}
