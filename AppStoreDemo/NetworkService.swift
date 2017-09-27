//
//  NetworkService.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 21..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation
import UIKit

struct NetworkService {
    
    static let imageCache = NSCache<NSString, AnyObject>()
        
    static func image(url:String, success: @escaping (UIImage?) -> (), failure: @escaping (Error) -> ()){
    
        if let cachedImage = imageCache.object(forKey: url as NSString) as? UIImage {
            success(cachedImage)
            return
        }
        
        self.request(url: url, success: { (data) in
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            if let image = image {
                imageCache.setObject(image, forKey: url as NSString)
                success(image)
            }else{
                //error
            }
        }) { (error) in
            failure(error)
        }
        
    }
    
    
    static func json(url:String, _ parameters:[String:String] = [:], success: @escaping (JSON?) -> (), failure: @escaping (Error) -> ()){
        
        self.request(url: url, parameters, success: { (data) in
            guard let data = data else { return }
            
            let json = JSONDecoder.decodeJSON(data)
            
            success(json)
        
        }) { (error) in
            failure(error)
        }
        
    }
    
    static func request(url:String, _ parameters:[String:String]? = [:], success: @escaping (Data?) -> (), failure: @escaping (Error) -> ()){
        
        var requestUrl = URL(string: url)
        if let parameters = parameters {

            if let urlComp = NSURLComponents(string: url) {
                var items = [URLQueryItem]()

                for (key,value) in parameters {
                    items.append(URLQueryItem(name: key, value: value))
                }
                
                items = items.filter{!$0.name.isEmpty}
                
                if !items.isEmpty {
                    urlComp.queryItems = items
                }
                
                if let urlCompUrl = urlComp.url {
                    requestUrl = urlCompUrl
                }
            }
            
        }
        
        if let requestUrl = requestUrl {
            let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async() {
                        success(data)
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async() {
                        failure(error)
                    }
                }
            }
            task.resume()
        }
    }
    
}


protocol API {
    static var baseUrl:String {get}
}

struct iTunesAPI:API {
    
    static let baseUrl = "https://itunes.apple.com"
    
    //https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json
    static func rss(country: String, type: String, limit: Int, genre: Int, contentType: String, success: @escaping (_ rss: RSS?) -> (), failure: @escaping (Error) -> ()){
        
        let url = "\(baseUrl)/\(country)/rss/\(type)/limit=\(limit)/genre=\(genre)/\(contentType)"
        
        NetworkService.json(url: url, success: { (json) in
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
        
        NetworkService.json(url: url, parameters, success: { (json) in
            let jsonDict = JSONDecoder.decodeDict(json)
            
            let result = AppResults.decode(jsonDict: jsonDict)
            success(result)

        }) { (error) in
            
            failure(error)
            
        }
        
    }
    
}

