//
//  AppShareButton.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 22..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit
import IoniconsSwift

protocol AppShareButtonDelegate: class{
    func appShareButtonTouched(button:UIButton)
}

class AppShareButton: UIButton {
    
    var appEntry: AppEntry?
    weak var delegate: AppShareButtonDelegate!
    weak var parentViewController: UIViewController?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        custom()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        custom()
    }
    
    func custom(){
        self.backgroundColor = self.tintColor //UIColor.init(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        self.setTitleColor(UIColor.white, for: .normal)
        let image = Ionicons.iosMore.image(25, color: .white)
        self.setImage(image, for: .normal)
        self.tintColor = .white
        self.layer.cornerRadius = self.bounds.size.width/2
        
        self.addTarget(self, action: #selector(share), for: .touchUpInside)
    }

    func share(){
        
        var activityItems:[Any] = []
        
        if let title = appEntry?.imName?.label{
            activityItems.append(title)
        }
        
        if let url = appEntry?.id?.label, let shareUrl = NSURL(string: url) {
            activityItems.append(shareUrl)
        }
        
        if let appIconImageUrl = appEntry?.imImage?.first?.label {
            
            Networking.request(appIconImageUrl).responseImage(success: { [weak self] (image) in
                if let image = image {
                    activityItems.append(image)
                }
                if let strongSelf = self {
                    strongSelf.presentActivityVC(activityItems: activityItems)
                }
            }, failure: { [weak self] (error) in
                if let strongSelf = self {
                    strongSelf.presentActivityVC(activityItems: activityItems)
                }
            })
            
        }else{
            presentActivityVC(activityItems: activityItems)
        }
        
    }
    
    func loadButtonTouched(button:UIButton) {
        delegate.appShareButtonTouched(button: button)
    }
    
    func presentActivityVC(activityItems: [Any]){
        let controller:UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        controller.excludedActivityTypes = [.assignToContact,.print,.saveToCameraRoll,.addToReadingList]
        self.parentViewController?.present(controller, animated: true, completion: nil)
    }

}

extension AppShareButton {
    
    func configureWith(appEntry: AppEntry, vc: UIViewController){
        self.appEntry = appEntry
        self.parentViewController = vc
    }
    
}
