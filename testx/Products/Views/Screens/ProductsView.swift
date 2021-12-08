//
//  ProductsView.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var productVM: ProductsViewModel
    @State var showCancelButton : Bool
    @State var searchText : String
    @Binding var cart : [Product]
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    SearchBarView(showCancelButton: $showCancelButton, searchText: $searchText)
                        .padding()
                    ScrollView{
                        ForEach(searchText != "" ? productVM.response.filter{
                            ($0.title ?? String()).lowercased().contains(searchText.lowercased()) || searchText == ""
                        } : productVM.response, id: \.self){ product in
                            NavigationLink(destination: ProductDetailView(product: product, cart: $cart), label: {
                                ProductRow(product: product)
                                    .padding(.horizontal)
                            })
                        }
                    }
                }
            }
            .navigationBarTitle(Text("products"), displayMode: .inline)
            .toolbar{
                HStack{
                    NavigationLink(destination: CartView(cart: $cart), label: {
                        Image("cart")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text(String(cart.count))
                    })
                        .foregroundColor(.white)
                }
            }
            .background(
                VStack(spacing: 0) {
                    LinearGradient(gradient: Gradient(colors: [Color("BlueOpacity"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                    Color("DarkBlue")
                }
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(showCancelButton: false, searchText: "", cart: .constant([]))
    }
}
