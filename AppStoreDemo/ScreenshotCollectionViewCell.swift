//
//  ScreenshotCollectionViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 23..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var screenshotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
    }
        
}

extension ScreenshotCollectionViewCell{
    
    func configuareWith(screenshotImageUrl: String){
        self.screenshotImageView.imageWith(url:screenshotImageUrl)
    }
    
}
