//
//  NetworkService.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 21..
//  Copyright © 2017년 develobe. All rights reserved.
//

/*
import Foundation
import UIKit

//네트워크 서비스
struct NetworkService {
    
    //이미지 캐쉬
    static let imageCache = NSCache<NSString, AnyObject>()
    
    //이미지 요청
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
                DispatchQueue.main.async() {
                    success(image)
                }
            }else{
                //error
            }
        }) { (error) in
            failure(error)
        }
        
    }
    
    //json 요청
    static func json(url:String, _ parameters:[String:String] = [:], success: @escaping (JSON?) -> (), failure: @escaping (Error) -> ()){
        
        self.request(url: url, parameters, success: { (data) in
            guard let data = data else { return }
            
            let json = JSONDecoder.decodeJSON(data)
            
            DispatchQueue.main.async() {
                success(json)
            }
        
        }) { (error) in
            failure(error)
        }
        
    }
    
    //요청
    static func request(url:String, _ parameters:[String:String]? = [:], success: @escaping (Data?) -> (), failure: @escaping (Error) -> ()){
        
        //get query 설정
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
        
        //timeout 설정
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 7
        urlconfig.timeoutIntervalForResource = 7
        let session = URLSession(configuration: urlconfig, delegate: nil, delegateQueue: nil)
        
        if let requestUrl = requestUrl {
            let task = session.dataTask(with: requestUrl) { (data, response, error) in
                if let data = data {
                    success(data)
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
*/
