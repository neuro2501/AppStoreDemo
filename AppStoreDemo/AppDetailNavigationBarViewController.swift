//
//  AppDetailNavigationBarViewController.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 27..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit
import IoniconsSwift

class AppDetailNavigationBarViewController: UIViewController {

    var titleImageView: AppIconImageView?
    var shareButton:AppShareButton?
    
    var isTitleImageViewAppear:Bool = false
    var threshold: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // left back button
        //setNavigationItemLeft()
        
    }
    
    func setNavigaionItemTitleViewWith(imageUrl: String){
        
        self.titleImageView = AppIconImageView(frame: CGRect(x: 0, y: 9.5, width: 30, height: 30), cornerRadius: 4)
        self.titleImageView?.imageWith(url: imageUrl)
        titleImageView?.contentMode = .scaleAspectFit

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
        titleView.addSubview(self.titleImageView!)
        titleView.bringSubview(toFront: self.titleImageView!)
        
        navigationItem.titleView = titleView
        
        //처음에 숨기기 위해서 필요함
        titleImageView?.alpha = 0.0
        navigationItem.titleView?.isHidden = true
    }
    
    func setNavigationItemLeft(){
        let backImage = Ionicons.iosArrowBack.image(33, color: .black)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popViewController))
    }
    
    func setNavigationItemRightWith(appEntry: AppEntry, vc: UIViewController){
        
        let appShareButton = AppShareButton(frame: CGRect(x: 0, y: 9.5, width: 25, height: 25))
        appShareButton.configureWith(appEntry: appEntry, vc: vc)
        appShareButton.tintColor = .white
        shareButton = appShareButton
        shareButton?.alpha = 0.0
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton!)
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        shareButton?.alpha = 0.0
        shareButton?.isHidden = true
    }
    
    func showItems(){
        isTitleImageViewAppear = true
        
        navigationItem.titleView?.isHidden = false
        titleImageView?.alpha = 0.0
        
        shareButton?.alpha = 0.0
        shareButton?.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.titleImageView?.alpha = 1.0
            var frame = self.titleImageView!.frame
            frame.origin.y = 7
            self.titleImageView?.frame = frame
            self.shareButton?.frame.origin.y = 0
            self.shareButton?.alpha = 1.0
        }, completion: nil)
    }
    
    func hideItems(){
        isTitleImageViewAppear = false
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.titleImageView?.alpha = 0.0
            //self.titleImageView?.frame.origin.y = 100
            var frame = self.titleImageView!.frame
            frame.origin.y = 9.5
            self.titleImageView?.frame = frame
            self.shareButton?.frame.origin.y = 2
            self.shareButton?.alpha = 0.0
        }, completion: nil)
    }
    
    func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }

}
