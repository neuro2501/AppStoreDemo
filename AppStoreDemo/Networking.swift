//
//  Networking.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 10. 6..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation
import UIKit

//TODO: 의존성 주입? 의존하는 객체들이 많은 듯하다.
//TODO: 성공 실패 클로저 타입얼라이언스 제네릭
//TODO: NetworkResponseManager 제너릭
//TODO: add error handler

//MARK: - Networking

struct Networking{
    
    var requestManager: NetworkRequestManager = NetworkRequestManager()//RequestManager
    var sessionManager: NetworkSessionManager  = NetworkSessionManager()//SessionManager
    var cacheManager: CacheManager = CacheManager()
    
    static func request(_ url: String, parameters:[String: String] = [:], method: HTTPMethod = .get) -> Networking{
        var networking = Networking()
        networking.requestManager = NetworkRequestManager(url: url, parameters: parameters, method: method)
        return networking
    }
    
    mutating func timeout(_ second: Double) -> Networking{
        self.sessionManager = NetworkSessionManager(timeout: second)
        return self
    }
    
    mutating func cache(_ active: Bool) -> Networking{
        self.cacheManager.active = active
        return self
    }
        
    func responseJSON(success: @escaping (JSON?) -> (), failure: @escaping (Error) -> ()){
        
        let jsonNetworkResponse:JSONNetworkResponse = JSONNetworkResponse(requestManager: self.requestManager, sessionManager: self.sessionManager, cacheManager: self.cacheManager)
        
        jsonNetworkResponse.response(success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
    
    func responseImage(success: @escaping (UIImage?) -> (), failure: @escaping (Error) -> ()){
        
        let imageNetworkResponse: ImageNetworkResponse = ImageNetworkResponse(requestManager: self.requestManager, sessionManager: self.sessionManager, cacheManager: self.cacheManager)
        
        imageNetworkResponse.response(success: { (image) in
            success(image)
        }) { (error) in
            failure(error)
        }
        
    }
    
    
    
}

//MARK: - HTTPMethod

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

//MARK: - CacheManager

struct CacheManager{
    
    let cacheData = NSCache<NSString, AnyObject>()
    var active:Bool = false
    
    func image(forKey url: String) -> UIImage?{
        guard active else { return nil }
        let cachedImage = cacheData.object(forKey: url as NSString) as? UIImage
        return cachedImage
    }
    
    func cache(image: UIImage, forKey key: String){
        guard active else { return }
        cacheData.setObject(image, forKey: key as NSString)
    }
    
    func cache(data: NSData, forKey key: String){
        guard active else { return }
        cacheData.setObject(data, forKey: key as NSString)
    }
    
}

//MARK: - NetworkSessionManager

struct NetworkSessionManager{
    
    var timeout: Double = 7
    
    func requestSession() -> URLSession{
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = timeout
        urlconfig.timeoutIntervalForResource = timeout
        let session = URLSession(configuration: urlconfig, delegate: nil, delegateQueue: nil)
        return session
        //return URLSession.shared
    }
    
}

//MARK: - NetworkRequestManager

struct NetworkRequestManager{
    
    var url: String?
    var parameters: [String:String]?
    var method: HTTPMethod?
    
    func requestUrl() -> URL?{
        
        guard let url = url else {
            return nil
        }
        
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
        
        return requestUrl
        
    }
    
}

//MARK: - NetworkResponseManager

protocol NetworkResponseManager {
    associatedtype ResponseType
    
    var requestManager: NetworkRequestManager {get set}
    var sessionManager: NetworkSessionManager {get set}
    var cacheManager: CacheManager {get set}
    
    func response(success: @escaping (ResponseType?) -> (), failure: @escaping (Error) -> ())
}


struct JSONNetworkResponse:NetworkResponseManager {
    
    typealias ResponseType = JSON
    
    var requestManager: NetworkRequestManager
    var sessionManager: NetworkSessionManager
    var cacheManager: CacheManager
    
    func response(success: @escaping (JSON?) -> (), failure: @escaping (Error) -> ()) {
        
        let requestUrl = self.requestManager.requestUrl()
        let requestSession = self.sessionManager.requestSession()
        
        let task = requestSession.dataTask(with: requestUrl!) { (data, response, error) in
            if let data = data {
                let json = JSONDecoder.decodeJSON(data)
                DispatchQueue.main.async() {
                    success(json)
                }
            } else if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async() {
                    failure(error)
                }
            }
        }
        task.resume()
        requestSession.finishTasksAndInvalidate()
    }
    
}


struct ImageNetworkResponse:NetworkResponseManager {
    
    typealias ResponseType = UIImage
    
    var requestManager: NetworkRequestManager
    var sessionManager: NetworkSessionManager
    var cacheManager: CacheManager
    
    func response(success: @escaping (UIImage?) -> (), failure: @escaping (Error) -> ()) {
        
        let requestUrl = self.requestManager.requestUrl()
        let requestSession = self.sessionManager.requestSession()
        let absUrl = requestUrl!.absoluteString
        
        if let cachedImage = cacheManager.image(forKey: absUrl) {
            success(cachedImage)
            return
        }
        
        if let requestUrl = requestUrl {
            let task = requestSession.dataTask(with: requestUrl) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    if let image = image {
                        self.cacheManager.cache(image: image, forKey: absUrl)
                        DispatchQueue.main.async() {
                            success(image)
                        }
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async() {
                        failure(error)
                    }
                }
            }
            task.resume()
            requestSession.finishTasksAndInvalidate()
        }
        
    }
    
}


