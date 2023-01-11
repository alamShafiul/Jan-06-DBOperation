//
//  KeyChain.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 11/1/23.
//

import Foundation

class KeyChain {
    static let shared = KeyChain()
    private init() {}
    
    func writeToKeyChain(email: String, service: String, data: String) {
        guard let data = try? JSONEncoder().encode(data) else {
            return
        }
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : email,
            kSecAttrService : service,
            kSecValueData : data
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status == errSecSuccess {
            print("done")
        }
        else {
            print("wow!!")
        }
    }
    
    func readFromKeyChain(email: String, service: String) -> String? {
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : email,
            kSecAttrService : service,
            kSecReturnData : true,
//            kSecReturnAttributes : true
            kSecMatchLimit : kSecMatchLimitOne
        ] as CFDictionary
        
        var result : AnyObject?
        
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess {
            if let result = result as? Data {
//                let val = try? JSONDecoder().decode(String.self, from: result)
//                print(val!)
//                return val
                //let x = String(data: result, encoding: .utf8)
                guard let x = try? JSONDecoder().decode(String.self, from: result) else {
                    return nil
                }
                print(x)
                return x
            }
        }
        return nil
    }
}
