//
//  PList.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 11/1/23.
//

import Foundation

class PList {
    static let shared = PList()
    private init() {}
    
    func writeToPlist(dict: [String : [String]]) {
        guard let resourceDirPath = Bundle.main.resourcePath else {
            return
        }
        let filePath = URL(filePath: resourceDirPath).appending(path: "custom.plist")
        let data = try? PropertyListSerialization.data(fromPropertyList: dict, format: .xml, options: 0)
        try? data?.write(to: filePath)
    }
    
    
    
    func readFromPlist() -> [String:[String]]? {
        guard let resourceDirPath = Bundle.main.resourcePath else {
            return nil
        }
        let filePath = URL(filePath: resourceDirPath).appending(path: "custom.plist")
        
        guard let data = try? Data(contentsOf: filePath) else {
            return nil
        }
        
        guard let readDict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String:[String]] else {
            return nil
        }
        return readDict
    }
}
