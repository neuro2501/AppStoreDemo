//
//  API.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 10. 2..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation

protocol API {
    static var baseUrl:String {get}
}

struct ItunesAPI: API {
    
    static let baseUrl = "https://itunes.apple.com"
    
    //https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json
    static func rss(country: String, type: String, limit: Int, genre: Int, contentType: String, success: @escaping (_ rss: RSS?) -> (), failure: @escaping (Error) -> ()){
        
        let url = "\(baseUrl)/\(country)/rss/\(type)/limit=\(limit)/genre=\(genre)/\(contentType)"

        Networking.request(url).responseJSON(success: { (json) in
            let jsonDict = JSONDecoder.decodeDict(json)
            let result = RSS.decode(jsonDict: jsonDict)
            success(result)
        }) { (error) in
            failure(error)
        }
        
    }
    
    //https://itunes.apple.com/lookup?id=1258016944&country=kr
    static func lookup(id: String, country: String, success: @escaping (_ appResults: AppResults?) -> (), failure: @escaping (Error) -> ()){
        
        let url = baseUrl + "/lookup"
        let parameters = ["id":id,"country":country]
        
        Networking.request(url, parameters: parameters).responseJSON(success: { (json) in
            let jsonDict = JSONDecoder.decodeDict(json)
            let result = AppResults.decode(jsonDict: jsonDict)
            success(result)
        }) { (error) in
            failure(error)
        }
        
    }
    
}

