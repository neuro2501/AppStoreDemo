//
//  ViewController.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 21..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit


class AppChartViewController: UIViewController {

    var rss: RSS?

    @IBOutlet var tableView: UITableView!
    var loadingView: LoadingView?
    var emptyView: EmptyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        self.emptyView = EmptyView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        self.emptyView?.delegate = self

        self.setNavigationBar()
        self.loadData()
        
    }
    
    
    func loadData(){
        
        self.showLoadingView()
        self.hideEmptyView()

        iTunesAPI.rss(country: "kr", type: "topfreeapplications", limit: 50, genre: 6015, contentType: "json", success: { [weak self](rss) in
            if let rss = rss, let strongSelf = self {
                strongSelf.rss = rss
                strongSelf.tableView.reloadData()
                strongSelf.tableView.tableFooterView = nil
                strongSelf.hideEmptyView()
                strongSelf.hideLoadingView()
            }
        }) { [weak self] (error) in
            if let strongSelf = self {
                strongSelf.showEmptyView()
                strongSelf.hideLoadingView()
            }
        }
        
    }
    
    func showLoadingView(){
        self.tableView.tableFooterView = loadingView
    }
    
    func hideLoadingView(){
        self.tableView.tableFooterView = nil
    }
    
    
    func showEmptyView(){
        self.tableView.backgroundView = emptyView
    }
    
    func hideEmptyView(){
        self.tableView.backgroundView = nil
    }
    
    func setNavigationBar(){
        self.title = "무료 금융 앱 순위"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAppDetailViewController" {
            
            if let cell = sender as? AppChartTableViewCell,
                let vc = segue.destination as? AppDetailViewController,
                let cellIndexPath = tableView.indexPath(for: cell) {
                let entry = rss?.feed?.entry
                if let entry = entry {
                    let row:Int = cellIndexPath.row
                    let appEntry = entry[row]
                    vc.appEntry = appEntry
                    vc.rank = row + 1
                }
            }
            
        }
        
    }

}


extension AppChartViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rss?.feedEntryCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AppChartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppChartTableViewCell", for: indexPath) as! AppChartTableViewCell
        
        let entry = rss?.feedEntry()
        if let entry = entry {
            let row = indexPath.row
            let appEntry = entry[row]
            cell.configureWith(appEntry: appEntry, rank: row+1)
            cell.shareButton.configureWith(appEntry: appEntry, vc: self)
        }
        
        return cell
    }
    

}

extension AppChartViewController: EmptyViewDelegate{
    
    func loadButtonTouched(button: UIButton) {
        self.loadData()
    }
    
}


