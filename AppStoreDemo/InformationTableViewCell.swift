//
//  InformationTableViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 23..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit
import IoniconsSwift

class InformationTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    var url: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

extension InformationTableViewCell{

    func configureWith(title: String){
        self.titleLabel.text = title
    }
    
    func configureWith(content: String){
        self.contentLabel.text = content
    }
    
    func configureWith(url: String){
        self.url = url
        let label = Ionicons.compass.label(20, color: self.tintColor)
        label.textAlignment = .right
        self.contentLabel.attributedText = label.attributedText
    }

    func openURL(){
        if let url = url, let requestUrl = URL(string: url){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(requestUrl)
            }            
        }
    }
}
