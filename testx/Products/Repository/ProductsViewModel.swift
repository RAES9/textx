//
//  ProductsViewModel.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import Foundation

class ProductsViewModel: ObservableObject {
    @Published var response = [Product]()
    
    init() {
        fetch()
    }
    
    func fetch() {
        let endpoint = "books.json"
        let api = API(endpoint: endpoint, parameters: [:])
        api.get { (string: String?, error, jsonString)  in
            let dict = string?.convertToArray() ?? []
            let jsonData = try? JSONSerialization.data(withJSONObject: dict)
            let instance = try? JSONDecoder().decode([Product].self, from: jsonData!)
            if let response: [Product] = instance {
                DispatchQueue.main.async {
                    self.response = response
                }
            }
        }
    }
}
