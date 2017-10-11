//
//  JSONDecoder.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 25..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation

typealias JSON = AnyObject
typealias JSONDictionary = [String: JSON]

protocol JSONDecodable{
    associatedtype T
    static func decode(jsonDict: JSONDictionary) -> T
}

struct JSONDecoder {
    
    static func decodeJSON(_ data: Data?) -> JSON? {
        
        do {
            if let data = data {
                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return result as JSON
            }else{
                return nil
            }
        } catch {
            //error
            return nil
        }
    }
    
    static func decodeString(_ object: JSON?) -> String {
        return object as? String ?? ""
    }
    
    static func decodeInt(_ object: JSON?) -> Int {
        return object as? Int ?? 0
    }
    
    static func decodeFloat(_ object: JSON?) -> Float {
        return object as? Float ?? 0.0
    }
    
    static func decodeBool(_ object: JSON?) -> Bool {
        return object as? Bool ?? false
    }
    
    static func decodeDict(_ object: JSON?) -> JSONDictionary {
        return object as? JSONDictionary ?? JSONDictionary()
    }
    
    static func decodeStringArray(_ array: JSON?) -> [String] {
        return array as? [String] ?? []
    }
    
    static func decodeDictArray(_ array: JSON?) -> [JSONDictionary] {
        return array as? [JSONDictionary] ?? []
    }
    
    static func decodeAppResults(_ array: JSON?) -> [AppResult] {
        return decodeDictArray(array).map(AppResult.decode)
    }
    
}
