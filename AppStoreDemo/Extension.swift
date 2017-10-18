//
//  Extension.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 26..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func imageWith(url:String?){
        self.image = #imageLiteral(resourceName: "icon_app_default")
        if let url = url {
            
            Networking.request(url).responseImage(success: { [weak self] (image) in
                if let strongSelf = self {
                    strongSelf.image = image ?? #imageLiteral(resourceName: "icon_app_default")
                }
            }, failure: { (error) in
                
            })
            
        }
    }
    
}

extension String {
    
    func byteToMegaByte() -> String{
        
        let byte = Float(self)
        if let byte = byte {
            let megaByte = byte/1024.0/1024.0
            let mb = String(format: "%.1f", megaByte)
            return "\(mb)MB"
        }else{
            return self
        }
        
    }
    
    func timeAgoSinceDate() -> String{
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        
        let currentDate = Date()
        
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!)년 전"
        } else if (components.year! >= 1){
            return "지난해"
        } else if (components.month! >= 2) {
            return "\(components.month!)달 전"
        } else if (components.month! >= 1){
            return "지난달"
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!)주 전"
        } else if (components.weekOfYear! >= 1){
            return "지난주"
        } else if (components.day! >= 2) {
            return "\(components.day!)일 전"
        } else if (components.day! >= 1){
            return "어제"
        } else if (components.hour! >= 2) {
            return "\(components.hour!)시간 전"
        } else if (components.hour! >= 1){
            return "1시간 전"
        } else if (components.minute! >= 2) {
            return "\(components.minute!)분 전"
        } else if (components.minute! >= 1){
            return "1분 전"
        } else if (components.second! >= 3) {
            return "\(components.second!)초 전"
        } else {
            return "방금"
        }
    }
    
}



