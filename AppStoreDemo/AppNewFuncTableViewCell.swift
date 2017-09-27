//
//  AppNewFuncTableViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 22..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

class AppNewFuncTableViewCell: UITableViewCell {

    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var releaseNotesLabel: UILabel!
    
    var isExpanded:Bool = false

    //releaseNotes
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension AppNewFuncTableViewCell{
    func configureWith(appResult: AppResult,_ isExpanded: Bool = false){
        
        self.isExpanded = isExpanded

        self.versionLabel.text = "버전 \(appResult.version)"
        
        self.dateLabel.text =  appResult.currentVersionReleaseDate.timeAgoSinceDate()
        self.releaseNotesLabel.text = appResult.releaseNotes
        self.releaseNotesLabel.numberOfLines = isExpanded ? 0 : 3
        self.releaseNotesLabel.lineBreakMode = .byWordWrapping
        
    }
}


