//
//  AppCopyrightTableViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 23..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

class AppCopyrightTableViewCell: UITableViewCell {
    
    @IBOutlet var copyrightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension AppCopyrightTableViewCell {
    func configureWith(rights: String){
        self.copyrightLabel.text = rights
        self.copyrightLabel.numberOfLines = 0
    }
}
