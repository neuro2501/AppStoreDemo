//
//  LoadingView.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 24..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

//TableView Loading at footerView
class LoadingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.startAnimating()
        activityIndicatorView.center = CGPoint(x:self.bounds.midX,y:self.bounds.midY)
        self.addSubview(activityIndicatorView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
