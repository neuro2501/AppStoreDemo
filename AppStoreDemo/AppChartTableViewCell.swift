//
//  AppChartTableViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 22..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

class AppChartTableViewCell: UITableViewCell {

    @IBOutlet var appIconImageView: AppIconImageView!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var seperatorView: SeperatorView!
    @IBOutlet var shareButton: AppShareButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension AppChartTableViewCell{
    
    func configureWith(appEntry: AppEntry, rank: Int){
                
        if rank == 1 {
            self.seperatorView.isHidden = true
        }else{
            self.seperatorView.isHidden = false
        }
        
        let imageUrl = appEntry.appIconImageUrl(size: .large)
        if let imageUrl = imageUrl {
            self.appIconImageView.imageWith(url: imageUrl)
        }
        self.rankLabel.text = "\(rank)"
        self.titleLabel.text = appEntry.title?.label ?? "Title"
        self.subTitleLabel.text = appEntry.subTitle
                
    }
}
