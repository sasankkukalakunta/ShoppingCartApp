//
//  MainView.swift
//  ShoppingCartApp
//
//  Created by kukalakunta sasank on 2/8/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ShoppingCartViewModel()
    @State private var showCart = false
    
    var body: some View {
        NavigationView {
            VStack {
                if showCart {
                    CartView(viewModel: viewModel)
                } else {
                    ProductListView(viewModel: viewModel)
                }
                
                Button(action: {
                    showCart.toggle()
                }) {
                    Text(showCart ? "Back to Products" : "Go to Cart")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle(showCart ? "Shopping Cart" : "Products")
        }
    }
}
