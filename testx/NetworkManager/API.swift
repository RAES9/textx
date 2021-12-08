//
//  API.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import Foundation
import UIKit

struct JSON {
    static let encoder = JSONEncoder()
}

class API {
    
    var url: String = EnvironmentVars.rootURL.absoluteString
    var parameters: [String: Any] = [:]
    var showErrors = true
    
    init(url: String, parameters: [String: Any]) {
        self.url = url
        self.parameters = parameters
    }
    
    init(endpoint: String, parameters: [String: Any]) {
        self.url = self.url + endpoint
        self.parameters = parameters
    }
    
    func get<T: Decodable>(completion: @escaping (_ value: T?, _ error: String?, _ jsonString: String?) -> ()) {
        var jsonString = String()
        let parameterArray = parameters.map { (key, value) -> String in
            return "\(key)=\(value)"
        }
        let parameterString = parameterArray.joined(separator: "&")
        guard let url = URL(string: "\(url)?\(parameterString)") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        let headersRequestString = String(describing: request.allHTTPHeaderFields)
        jsonString = "request:\n" + headersRequestString + "\n" + parameterString
        self.request(urlRequest: request, jsonString: jsonString) { (value: String?, error, jsonString)  in
            completion(value as? T, error, jsonString)
        }
    }
    
    private func request<T: Decodable>(urlRequest: URLRequest, jsonString: String, completion: @escaping (_ value: T?,_ error: String?, _ jsonString: String?) -> ()) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title:  "Try again! 😓", message: "Review your connection", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: String()), style: .default, handler: nil))
                    if let topVC = UIApplication.getTopViewController() {
                        topVC.present(alert, animated: true, completion: nil)
                    }
                    completion(nil, "Review request", jsonString)
                }
                return
            }
            let responseString = String(data: data, encoding: .utf8) ?? "{}"
            let value = try? JSONDecoder().decode(T.self, from: data)
            if T.self == String.self {
                completion(responseString as? T, nil, jsonString)
            } else {
                completion(value, nil, jsonString)
            }
        }.resume()
    }
    
}


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

enum HTTPMethod: String {
    case GET
}
