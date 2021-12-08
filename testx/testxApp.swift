//
//  testxApp.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import SwiftUI

@main
struct testxApp: App {
    @StateObject private var productVM = ProductsViewModel()
    @State private var cart = [Product]()
    
    var body: some Scene {
        WindowGroup {
            ProductsView(showCancelButton: false, searchText: "", cart: $cart)
                .environmentObject(productVM)
        }
    }
}
