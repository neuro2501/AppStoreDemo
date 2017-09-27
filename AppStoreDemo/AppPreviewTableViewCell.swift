//
//  AppPreviewTableViewCell.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 23..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

class AppPreviewTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
        
    var appResult: AppResult?
    var screenshotUrls: [String]? {
        didSet{
            collectionView.reloadData()
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

extension AppPreviewTableViewCell{
    func configureWith(appResult: AppResult){
        //screenshotUrls
        self.appResult = appResult
        self.screenshotUrls = appResult.screenshotUrls
    }
    
    func requiredHeight() -> CGFloat{
        let titleLabelHeight = titleLabel.bounds.size.height
        let screenshotHeight = appResult?.screenshotSize().height ?? 0
        //TODO: constraint constant 가지고 와서 해야함
        return 16 + titleLabelHeight + 8 + screenshotHeight + 2 + 16
    }
}

extension AppPreviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ScreenshotCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCollectionViewCell", for: indexPath) as! ScreenshotCollectionViewCell
        
        if let screenshotImageUrl = screenshotUrls?[indexPath.row]{
            cell.configuareWith(screenshotImageUrl: screenshotImageUrl)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return appResult?.screenshotSize() ?? CGSize.zero
    }

}
