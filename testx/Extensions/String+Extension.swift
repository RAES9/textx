//
//  String+Extension.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import Foundation

extension String {
      
    func convertToArray() -> Array<[String: Any]>? {
        var array: Array<[String: Any]>?
        if let data = data(using: String.Encoding.utf8) {
            do {
                array = try JSONSerialization.jsonObject(with: data, options: []) as? Array<[String: Any]>
            } catch let error as NSError {
                print(error)
            }
        }
        return array
    }
}
