//
//  EnvironmentVars.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import Foundation

public enum EnvironmentVars {
    
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let rootURL = "ROOT_URL"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let rootURL: URL = {
        guard let rootURLstring = EnvironmentVars.infoDictionary[Keys.Plist.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
    
}
