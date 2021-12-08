//
//  ProductRow.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import SwiftUI

struct ProductRow: View {
    
    var product : Product
    
    var body: some View {
        ZStack{
            HStack{
                ZStack{
                    if #available(iOS 15.0, *) {
                        AsyncImage(
                            url: URL(string: product.imageURL ?? String()),
                            content: { image in
                                image
                                    .resizable()
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .cornerRadius(6)
                            }, placeholder: {
                                Image("film_default")
                                    .resizable()
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .cornerRadius(6)
                            }
                        )
                    } else {
                        CustomAsyncImage(
                            url:
                                URL(string: product.imageURL ?? String()),
                            placeholder: {
                                Image("film_default")
                                    .resizable()
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .cornerRadius(6)
                            },
                            image: {
                                Image(uiImage: $0)
                                    .resizable()
                            }
                        )
                            .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3) // 2:3 aspect ratio
                            .cornerRadius(16)
                    }
                }
                .frame(maxWidth: 50, maxHeight: 50)
                .cornerRadius(6)
                VStack{
                    HStack{
                        Text(product.title ?? "")
                            .lineLimit(3)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    if product.author != "" {
                        HStack{
                            Text(product.author ?? "")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
        .foregroundColor(.white)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .frame(height: 100)
        .background(
            Color("DarkBlue"))
        .cornerRadius(5)
    }
    
}

struct FilmRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product())
    }
}
