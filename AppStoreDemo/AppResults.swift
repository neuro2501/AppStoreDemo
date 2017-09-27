//
//  JSONParser.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 21..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation
import UIKit

class AppResults {
 
    let resultCount: Int
    let results: [AppResult]?
 
    init(resultCount: Int, results: [AppResult]?) {
        self.resultCount = resultCount
        self.results = results
    }
    
    func result() -> AppResult?{
        return results?.first
    }
    
    static func decode(jsonDict: JSONDictionary) -> AppResults {
        
        let resultCount = JSONDecoder.decodeInt(jsonDict["resultCount"])
        let results = JSONDecoder.decodeAppResults(jsonDict["results"])
        
        return AppResults(resultCount: resultCount, results: results)
    
    }
}

struct AppResult: JSONDecodable {
    
    let ipadScreeshotUrls: [String]
    let appletvScreenshotUrls: [String]
    let artworkUrl512: String
    let isGameCenterEnabled: Bool
    let version: String
    let artistId: String
    let artistName: String

    let genres: [String]
    let averageUserRating: Float
    let userRatingCount: Int
    let userRatingCountForCurrentVersion: Int
    let averageUserRatingForCurrentVersion: Float
    
    let trackContentRating: String
    
    let currentVersionReleaseDate: String
    let releaseNotes: String
    
    let screenshotUrls: [String]
    
    let desc: String
    
    let sellerName: String
    let sellerUrl: String
    
    let fileSizeBytes: String
    
    let supportedDevices: [String]
    let minimumOsVersion: String
    
    let languageCodesISO2A: String
    
    //TODO: 함수가 맞는가 프로퍼티에서 이렇게 하는게 맞는가?
    var hasMuchUserRatingCountForCurrentVersion: Bool {
        return (userRatingCountForCurrentVersion > 20) ? true : false
    }
    
    func mainGenre() -> String{
        return genres.first ?? ""
    }
    
    func userRatingForCurrentVersionWithStar() -> String{
        if hasMuchUserRatingCountForCurrentVersion {
            return "\(averageUserRatingForCurrentVersion) \(userRatingForCurrentVersionStar())"
        }else{
            return "-----"
        }
    }
    
    func userRatingForCurrentVersionStar()->String{
        
        var star = ""
        
        for index in 0...4 {
            
            let index = Float(index)
        
            if index > averageUserRatingForCurrentVersion {
                star += "1 "
            }else if index >= averageUserRatingForCurrentVersion - 0.5 {
                star += ".5 "
            }else{
                star += "0 "
            }
            
        }
        
        return star
        
    }
    
    func userRatingCountForCurrentVersionDesc() -> String{
        if hasMuchUserRatingCountForCurrentVersion {
            return "\(userRatingCountForCurrentVersion)개의 평가"
        }else{
            return "평가부족"
        }
    }
    
    func screenshotSize() -> CGSize{
        
        let bounds = UIScreen.main.bounds
        let deviceWidth = bounds.size.width
        let deviceHeight = bounds.size.height
        
        let width = CGFloat(200)
        let height = width * deviceHeight / deviceWidth
        
        return CGSize(width: width, height: height)

    }
    
    
    //TODO: if문 없애야함
    func informationList() -> [[String:String]] {
        
        var list:[[String:String]] = []
        
        //
        //판매자, 크기, 카테고리, 호환성, 언어, 연령, 개발자 웹 사이트, 개인정보 취급방침
        //

        //판매자
        if sellerName != "" {
            list.append(["key":"sellerName","content":sellerName,"label":"판매자"])
        }
        
        //크기
        if fileSizeBytes != "" {
            list.append(["key":"fileSizeBytes","content":fileSizeBytes.byteToMegaByte(),"label":"크기"])
        }
        
        //호환성
        
        
        //언어
        if languageCodesISO2A != "" {
            list.append(["key":"languageCodesISO2A","content":languageCodesISO2A,"label":"언어"])
        }
        
        //연령
        if trackContentRating != "" {
            list.append(["key":"trackContentRating","content":trackContentRating,"label":"연령"])
        }
        
        //개발자 웹 사이트
        if sellerUrl != "" {
            list.append(["key":"sellerUrl","url":sellerUrl,"label":"개발자 웹 사이트"])
        }
        
        return list
    }
    
    static func decode(jsonDict: JSONDictionary) -> AppResult {
        
        let ipadScreeshotUrls = JSONDecoder.decodeStringArray(jsonDict["ipadScreeshotUrls"])
        let appletvScreenshotUrls = JSONDecoder.decodeStringArray(jsonDict["appletvScreenshotUrls"])
        let artworkUrl512 = JSONDecoder.decodeString(jsonDict["artworkUrl512"])
        let isGameCenterEnabled = JSONDecoder.decodeBool(jsonDict["isGameCenterEnabled"])
        let version = JSONDecoder.decodeString(jsonDict["version"])
        let artistId = JSONDecoder.decodeString(jsonDict["artistId"])
        let artistName = JSONDecoder.decodeString(jsonDict["artistName"])
        let genres = JSONDecoder.decodeStringArray(jsonDict["genres"])

        let averageUserRating = JSONDecoder.decodeFloat(jsonDict["averageUserRating"])
        let userRatingCount = JSONDecoder.decodeInt(jsonDict["userRatingCount"])
        let userRatingCountForCurrentVersion = JSONDecoder.decodeInt(jsonDict["userRatingCountForCurrentVersion"])
        let averageUserRatingForCurrentVersion = JSONDecoder.decodeFloat(jsonDict["averageUserRatingForCurrentVersion"])
        let trackContentRating = JSONDecoder.decodeString(jsonDict["trackContentRating"])
        
        let currentVersionReleaseDate = JSONDecoder.decodeString(jsonDict["currentVersionReleaseDate"])
        let releaseNotes = JSONDecoder.decodeString(jsonDict["releaseNotes"])
        
        let screenshotUrls = JSONDecoder.decodeStringArray(jsonDict["screenshotUrls"])
        
        let desc = JSONDecoder.decodeString(jsonDict["description"])
        
        let sellerName = JSONDecoder.decodeString(jsonDict["sellerName"])
        let sellerUrl = JSONDecoder.decodeString(jsonDict["sellerUrl"])
        
        let fileSizeBytes = JSONDecoder.decodeString(jsonDict["fileSizeBytes"])
        
        let supportedDevices = JSONDecoder.decodeStringArray(jsonDict["supportedDevices"])
        let minimumOsVersion = JSONDecoder.decodeString(jsonDict["minimumOsVersion"])
        
        let languageCodesISO2A = JSONDecoder.decodeString(jsonDict["languageCodesISO2A"])
        
        return AppResult(ipadScreeshotUrls: ipadScreeshotUrls, appletvScreenshotUrls: appletvScreenshotUrls, artworkUrl512: artworkUrl512, isGameCenterEnabled: isGameCenterEnabled, version: version, artistId: artistId, artistName: artistName, genres: genres, averageUserRating: averageUserRating, userRatingCount: userRatingCount, userRatingCountForCurrentVersion: userRatingCountForCurrentVersion, averageUserRatingForCurrentVersion: averageUserRatingForCurrentVersion, trackContentRating: trackContentRating, currentVersionReleaseDate: currentVersionReleaseDate, releaseNotes: releaseNotes, screenshotUrls: screenshotUrls, desc: desc,sellerName: sellerName,sellerUrl:sellerUrl, fileSizeBytes: fileSizeBytes, supportedDevices: supportedDevices, minimumOsVersion: minimumOsVersion, languageCodesISO2A: languageCodesISO2A)
        
    }
    
}

