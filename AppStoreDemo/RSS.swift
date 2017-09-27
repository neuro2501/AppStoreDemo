//
//  RSS.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 25..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation

//MARK: - RSS

class RSS {
    
    let feed: Feed?
    
    init(feed: Feed) {
        self.feed = feed
    }
    
    func feedEntryCount() -> Int{
        return feed?.entry?.count ?? 0
    }
    
    func feedEntry() -> [AppEntry]?{
        return feed?.entry
    }
    
    static func decode(jsonDict: JSONDictionary) -> RSS {
        
        let feedDict = JSONDecoder.decodeDict(jsonDict["feed"])
        let feed = Feed.decode(jsonDict: feedDict)
        
        return RSS(feed: feed)
    }
}

struct Feed: JSONDecodable {
    let entry: [AppEntry]?
    
    static func decode(jsonDict: JSONDictionary) -> Feed {
        
        let entryDict = JSONDecoder.decodeDictArray(jsonDict["entry"])
        let entry = entryDict.map(AppEntry.decode)
        
        return Feed(entry: entry)
    }
}

//MARK: - AppEntry

//TODO: 앱내구입
struct AppEntry: JSONDecodable {
    
    let imName: IMName?
    let imImage: [IMImage]?
    let imPrice: IMPrice?
    let title: Title?
    let id: Id?
    let category: Category?
    let imArtist: IMArtist?
    let rights: Rights?
    
    func appId() -> String?{
        return id?.attributes?.imId
    }
    
    func genre() -> String?{
        return category?.attributes?.label
    }
    
    //TODO: 메소드말고 프로퍼티로 할 수 없을까?
    func subTitle() -> String {
        return imArtist?.label ?? category?.attributes?.label ?? ""
    }
    
    func appIconImageUrl(size: AppIconImageSize) -> String?{
        
        guard let imImage = imImage else {return nil}
        
        switch size {
        case .small:
            if imImage.indices.contains(0) {
                return imImage[0].label
            }else{
                return nil
            }
        case .medium:
            if imImage.indices.contains(1) {
                return imImage[1].label
            }else{
                return nil
            }
        case .large:
            if imImage.indices.contains(2) {
                return imImage[2].label
            }else{
                return nil
            }
        default:
            return nil
        }
    }

    enum AppIconImageSize {
        case small
        case medium
        case large
    }
    
    static func decode(jsonDict: JSONDictionary) -> AppEntry{
        
        let imNameDict = JSONDecoder.decodeDict(jsonDict["im:name"])
        let imName = IMName.decode(jsonDict: imNameDict)
        
        let imImageDict = JSONDecoder.decodeDictArray(jsonDict["im:image"])
        let imImage = imImageDict.map(IMImage.decode)
        
        let imPriceDict = JSONDecoder.decodeDict(jsonDict["im:price"])
        let imPrice = IMPrice.decode(jsonDict: imPriceDict)
        
        let titleDict = JSONDecoder.decodeDict(jsonDict["title"])
        let title = Title.decode(jsonDict: titleDict)
        
        let idDict = JSONDecoder.decodeDict(jsonDict["id"])
        let id = Id.decode(jsonDict: idDict)
        
        let categoryDict = JSONDecoder.decodeDict(jsonDict["category"])
        let category = Category.decode(jsonDict: categoryDict)
        
        let imArtistDict = JSONDecoder.decodeDict(jsonDict["im:artist"])
        let imArtist = IMArtist.decode(jsonDict: imArtistDict)
        
        let rightsDict = JSONDecoder.decodeDict(jsonDict["rights"])
        let rights = Rights.decode(jsonDict: rightsDict)
        
        return AppEntry(imName: imName, imImage: imImage, imPrice: imPrice, title: title, id: id, category: category, imArtist: imArtist, rights: rights)
        
    }
    
}

struct IMName: JSONDecodable{
    let label: String?
    
    static func decode(jsonDict: JSONDictionary) -> IMName{
        
        let label = JSONDecoder.decodeString(jsonDict["label"])
        return IMName(label: label)
        
    }
}

struct IMImage: JSONDecodable {
    
    let label:String
    let attributes: IMImageAttributes?
    
    static func decode(jsonDict: JSONDictionary) -> IMImage{
        
        let label = JSONDecoder.decodeString(jsonDict["label"])
        let attributesDict = JSONDecoder.decodeDict(jsonDict["attributes"])
        let attributes = IMImageAttributes.decode(jsonDict: attributesDict)
        
        return IMImage(label: label, attributes: attributes)
        
    }
}

struct IMImageAttributes: JSONDecodable {
    
    let height:Int
    
    static func decode(jsonDict: JSONDictionary) -> IMImageAttributes{
        
        let height = JSONDecoder.decodeInt(jsonDict["heigth"])
        
        return IMImageAttributes(height: height)
    }
}

struct IMPrice: JSONDecodable {
    
    let label:String
    let attributes: IMPriceAttributes?
    
    static func decode(jsonDict: JSONDictionary) -> IMPrice{
        
        let label = JSONDecoder.decodeString(jsonDict["label"])
        let attributesDict = JSONDecoder.decodeDict(jsonDict["attributes"])
        let attributes = IMPriceAttributes.decode(jsonDict: attributesDict)
        
        return IMPrice(label: label, attributes: attributes)
        
    }
}

struct IMPriceAttributes: JSONDecodable {
    
    let amount: String
    let currency: String
    
    static func decode(jsonDict: JSONDictionary) -> IMPriceAttributes{
        
        let amount = JSONDecoder.decodeString(jsonDict["amount"])
        let currency = jsonDict["currency"] as? String ?? ""
        
        return IMPriceAttributes(amount: amount, currency: currency)
    }
}

//TODO: 접두사 달아야할듯
struct Title: JSONDecodable {
    let label: String
    
    static func decode(jsonDict: JSONDictionary) -> Title{
        
        let label = JSONDecoder.decodeString(jsonDict["label"])
        return Title(label: label)
        
    }
}

struct Id: JSONDecodable {
    
    let label:String
    let attributes: IdAttributes?
    
    static func decode(jsonDict: JSONDictionary) -> Id{
        
        let label = JSONDecoder.decodeString(jsonDict["label"])
        let attributesDict = JSONDecoder.decodeDict(jsonDict["attributes"])
        let attributes = IdAttributes.decode(jsonDict: attributesDict)
        
        return Id(label: label, attributes: attributes)
        
    }
}

struct IdAttributes: JSONDecodable {
    
    let imId: String
    let imBundleId: String
    
    static func decode(jsonDict: JSONDictionary) -> IdAttributes{
        
        let imId = JSONDecoder.decodeString(jsonDict["im:id"])
        let imBundleId = JSONDecoder.decodeString(jsonDict["im:bundelId"])
        
        return IdAttributes(imId: imId, imBundleId: imBundleId)
    }
}

struct Category: JSONDecodable {
    
    let attributes: CategoryAttributes?
    
    static func decode(jsonDict: JSONDictionary) -> Category{
        
        let attributesDict = JSONDecoder.decodeDict(jsonDict["attributes"])
        let attributes = CategoryAttributes.decode(jsonDict: attributesDict)
        
        return Category(attributes: attributes)
        
    }
}

struct CategoryAttributes: JSONDecodable {
    
    let imId: String
    let term: String
    let scheme: String
    let label: String
    
    static func decode(jsonDict: JSONDictionary) -> CategoryAttributes{
        
        let imId = JSONDecoder.decodeString(jsonDict["im:id"])
        let term = JSONDecoder.decodeString(jsonDict["term"])
        let scheme = JSONDecoder.decodeString(jsonDict["scheme"])
        let label = JSONDecoder.decodeString(jsonDict["label"])
        
        return CategoryAttributes(imId: imId, term: term, scheme: scheme, label: label)
    }
}

struct IMArtist: JSONDecodable  {
    let label: String
    
    static func decode(jsonDict: JSONDictionary) -> IMArtist{
        
        let label = JSONDecoder.decodeString(jsonDict["label"])
        
        return IMArtist(label: label)
        
    }
}
struct Rights: JSONDecodable  {
    let label: String
    
    static func decode(jsonDict: JSONDictionary) -> Rights{
        
        let label = JSONDecoder.decodeString(jsonDict["label"])
        
        return Rights(label: label)
        
    }
}

