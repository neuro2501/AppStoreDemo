//
//  LoadingView.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 24..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    var activityIndicatorView: UIActivityIndicatorView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        if let activityIndicatorView = self.activityIndicatorView {
            activityIndicatorView.startAnimating()
            activityIndicatorView.center = CGPoint(x:self.bounds.midX,y:self.bounds.midY)
            self.addSubview(activityIndicatorView)
        }
    }

}
