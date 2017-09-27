//
//  AppIconImageView.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 22..
//  Copyright © 2017년 develobe. All rights reserved.
//

import Foundation
import UIKit

class AppIconImageView: UIImageView{
    
    init(frame: CGRect, cornerRadius: CGFloat){
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        custom()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 16
        custom()
    }
    
    func custom(){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
    
}
