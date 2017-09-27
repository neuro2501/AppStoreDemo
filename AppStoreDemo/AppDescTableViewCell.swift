//
//  AppDescTableViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 23..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

//TODO: canMakeCell 넣어야할 듯

class AppDescTableViewCell: UITableViewCell {

    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    var isExpanded:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension AppDescTableViewCell {
    
    func configureWith(appResult: AppResult,_ isExpanded: Bool = false){
        self.isExpanded = isExpanded
        self.artistLabel.text = appResult.artistName
        self.descLabel.text = appResult.desc
        self.descLabel.numberOfLines = isExpanded ? 0 : 3
        self.descLabel.lineBreakMode = .byWordWrapping
    }
    
}
