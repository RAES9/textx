//
//  CartView.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import SwiftUI

struct CartView: View {
    @Binding var cart : [Product]
    
    var body: some View {
        ZStack{
            VStack{
                List {
                    ForEach(cart, id: \.self){ product in
                        ProductRow(product: product)
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        .navigationBarTitle(Text("cart"), displayMode: .inline)
        .background(
            VStack(spacing: 0) {
                LinearGradient(gradient: Gradient(colors: [Color("BlueOpacity"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                Color("DarkBlue")
            }
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    func delete(at offset: IndexSet) {
        cart.remove(atOffsets: offset)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cart: .constant([]))
    }
}
