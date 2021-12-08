//
//  ProductDetailView.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product : Product
    @Binding var cart : [Product]
    
    var body: some View {
        ZStack{
            VStack{
               ProductRow(product: product)
                    .padding()
                Spacer()
                Button(action: {
                    cart.append(product)
                } , label: {
                    Text("add")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .foregroundColor(.white)
                        .font(.title3.bold())
                        .background(Color("Blue"))
                        .cornerRadius(26)
                })
                    .padding()
            }
        }
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
        .navigationBarTitle(Text("detail"), displayMode: .inline)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(), cart: .constant([]))
    }
}
