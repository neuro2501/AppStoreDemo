//
//  AppDetailHeaderView.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 22..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit
import HCSStarRatingView

class AppDetailHeaderView: UIView {
    
    @IBOutlet var appIconImageView: AppIconImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var shareButton: AppShareButton!
    
    @IBOutlet var starRatingView: HCSStarRatingView!

    @IBOutlet var userRatingLabel: UILabel!
    @IBOutlet var userRatingCountDescLabel: UILabel!
    @IBOutlet var userRatingLedingConstraint: NSLayoutConstraint!
    
    @IBOutlet var genreRankLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    @IBOutlet var ageRatingLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}

extension AppDetailHeaderView{
    
    func configureWith(appEntry: AppEntry){
        if let imageURL = appEntry.appIconImageUrl(size: .large) {
            self.appIconImageView.imageWith(url: imageURL)
        }
        self.titleLabel.text = appEntry.title?.label ?? "Title"
        self.artistLabel.text = appEntry.imArtist?.label ?? "Artist"
    }
    
    func configureWith(appResult: AppResult, rank: Int, genre: String){
        
        self.genreRankLabel.text = "#\(rank)"
        self.genreLabel.text = genre
        
        self.starRatingView.isUserInteractionEnabled = false

        if appResult.hasMuchUserRatingCountForCurrentVersion {
            let averageUserRatingForCurrentVersion = appResult.averageUserRatingForCurrentVersion
            self.userRatingLabel.text = "\(averageUserRatingForCurrentVersion)"
            self.starRatingView.value = CGFloat(averageUserRatingForCurrentVersion)
            self.userRatingCountDescLabel.text = appResult.userRatingCountForCurrentVersionDesc()
        }else{
            self.userRatingLabel.text = ""
            self.userRatingLedingConstraint.constant = 0.0
            self.userRatingCountDescLabel.text = appResult.userRatingCountForCurrentVersionDesc()
        }
        
        self.ageRatingLabel.text = appResult.trackContentRating
  
    }
}
