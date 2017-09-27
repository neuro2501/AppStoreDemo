//
//  AppInfoTableViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 23..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

class AppInfoTableViewCell: UITableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var appResult: AppResult? {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension AppInfoTableViewCell {
    
    func configureWith(appResult:AppResult){
        self.appResult = appResult
    }
    
    func requiredHeight() -> CGFloat{
        
        let titleLabelHeight = titleLabel.bounds.size.height
        
        if let appResult = appResult {
            let tableViewHeight = CGFloat(appResult.informationList().count * 44)
            let defaultHeigth = CGFloat(16 + 8 + 16)
            return defaultHeigth + tableViewHeight + titleLabelHeight
        }else{
            return 0
        }
        
    }
    
}

extension AppInfoTableViewCell: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appResult?.informationList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:InformationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
        

        if let informationList = appResult?.informationList() {
            
            let information = informationList[indexPath.row]

            if let label = information["label"]{
                cell.configureWith(title: label)
                if let content = information["content"] {
                    cell.configureWith(content: content)
                }else if let url = information["url"] {
                    cell.configureWith(url: url)
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:InformationTableViewCell = tableView.cellForRow(at: indexPath) as! InformationTableViewCell
        cell.openURL()
    }

}


