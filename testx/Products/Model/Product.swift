//
//  Product.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import Foundation

class Product: Codable, Hashable {

    var title: String?
    var author: String?
    var imageURL: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.title == rhs.title
    }
}

extension Product {
    func decoder() -> [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
