//
//  AppDetailViewController.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 22..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit
import IoniconsSwift

class AppDetailViewController: AppDetailNavigationBarViewController {

    var appEntry:AppEntry!
    var rank: Int!
    var appResults: AppResults?
    var isDragging: Bool = false

    //view
    @IBOutlet var tableView: UITableView!
    @IBOutlet var appDetailHeaderView: AppDetailHeaderView!
    var loadingView: LoadingView!
    
    //cell
    var appNewFuncTableViewCell: AppNewFuncTableViewCell?
    var appPreviewTableViewCell: AppPreviewTableViewCell?
    var appInfoTableViewCell: AppInfoTableViewCell?
    var appDescTableViewCell: AppDescTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))

        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44.0;
        
        setHeaderView(appEntry: appEntry)
        self.setNavigationItemRightWith(appEntry: appEntry, vc: self)
        if let appId = appEntry.appId {
            self.loadData(appId: appId)
        }
        
    }
        
    func loadData(appId: String){
        
        self.showLoadingView()
        
        ItunesAPI.lookup(id: appId, country: "kr", success: { [weak self] (appResults) in
            
            if let strongSelf = self {
                strongSelf.hideLoadingView()
                strongSelf.appResults = appResults
                if let appResult = appResults?.firstResult, let rank = strongSelf.rank, let genre = strongSelf.appEntry.genre {
                    strongSelf.appDetailHeaderView.configureWith(appResult: appResult, rank: rank, genre: genre)
                    if let iconImageUrl = strongSelf.appEntry.appIconImageUrl(size: .medium){
                        strongSelf.setNavigaionItemTitleViewWith(imageUrl: iconImageUrl)
                    }
                    strongSelf.tableView.reloadData()
                }
            }
            
        }, failure: { [weak self]  (error) in
            self?.hideLoadingView()
        })
    }
    
    func showLoadingView(){
        self.tableView.tableFooterView = loadingView
    }
    
    func hideLoadingView(){
        self.tableView.tableFooterView = nil
    }
    
    func setHeaderView(appEntry: AppEntry){
        appDetailHeaderView.configureWith(appEntry: appEntry)
        appDetailHeaderView.shareButton.configureWith(appEntry: appEntry, vc: self)
    }
    
}

extension AppDetailViewController: UIScrollViewDelegate {
    
    func setAppearTitleImageView(scrollViewY: CGFloat){
        if scrollViewY > self.threshold{
            if !self.isTitleImageViewAppear {
                self.showItems()
            }
        }else{
            if self.isTitleImageViewAppear {
                self.hideItems()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDragging = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDragging = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isDragging {
            setAppearTitleImageView(scrollViewY: scrollView.contentOffset.y)
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        setAppearTitleImageView(scrollViewY: scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setAppearTitleImageView(scrollViewY: scrollView.contentOffset.y)
    }
    
}


extension AppDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if appResults != nil {
            return 5
        }else{
            return 0
        }
    
    }
    
    //TODO: array로 순서 결정하도록 해야하나? 타입으로? canMakeCell과 함꼐?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }else if indexPath.row == 1 {
        
            if appPreviewTableViewCell != nil {
                return appPreviewTableViewCell!.requiredHeight()
            }else{
                return 0
            }
        
        }else if indexPath.row == 2{
            return UITableViewAutomaticDimension
        }else if indexPath.row == 3{
            
            if appInfoTableViewCell != nil {
                return appInfoTableViewCell!.requiredHeight()
            }else{
                return 0
            }
            
        }else if indexPath.row == 4{
            return UITableViewAutomaticDimension
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            appNewFuncTableViewCell?.isExpanded = true
            tableView.reloadRows(at: [indexPath], with: .fade)
        }else if indexPath.row == 2 {
            appDescTableViewCell?.isExpanded = true
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:AppNewFuncTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppNewFuncTableViewCell", for: indexPath) as! AppNewFuncTableViewCell
            
            if let appResult = appResults?.firstResult {
                cell.configureWith(appResult: appResult,appNewFuncTableViewCell?.isExpanded ?? false)
                appNewFuncTableViewCell = cell
            }
            
            return cell
        }else if indexPath.row == 1 {
            let cell:AppPreviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppPreviewTableViewCell", for: indexPath) as! AppPreviewTableViewCell
            
            if let appResult = appResults?.firstResult {
                cell.configureWith(appResult: appResult)
                appPreviewTableViewCell = cell
            }
            
            return cell
        }else if indexPath.row == 2 {
            
            let cell:AppDescTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppDescTableViewCell", for: indexPath) as! AppDescTableViewCell
            
            if let appResult = appResults?.firstResult {
                cell.configureWith(appResult: appResult, appDescTableViewCell?.isExpanded ?? false)
                appDescTableViewCell = cell
            }
            
            return cell
        }else if indexPath.row == 3{
        
            let cell:AppInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppInfoTableViewCell", for: indexPath) as! AppInfoTableViewCell
            
            if let appResult = appResults?.firstResult {
                cell.configureWith(appResult: appResult)
                appInfoTableViewCell = cell
            }
            
            return cell
        
        }else if indexPath.row == 4{
            
            let cell:AppCopyrightTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppCopyrightTableViewCell", for: indexPath) as! AppCopyrightTableViewCell
            
            if let appEntry = appEntry, let rights = appEntry.rights?.label{
                cell.configureWith(rights: rights)
            }
            
            return cell
            
        }else{
            let cell:AppChartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppChartTableViewCell", for: indexPath) as! AppChartTableViewCell
            
            return cell
        }
        
    }
    
    
}

