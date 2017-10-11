//
//  EmptyView.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 9. 26..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit


protocol EmptyViewDelegate: class {
    func loadButtonTouched(button:UIButton)
}

class EmptyView: UIView {

    weak var delegate: EmptyViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 100, width: frame.width, height: 100))
        messageLabel.text = "App Store에 연결할 수 없음"
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "", size: 20)
        
        let loadButton = UIButton(frame: CGRect(x: (frame.width-100)/2, y: 200, width: 100, height: 25))
        loadButton.layer.cornerRadius = 4.0
        loadButton.layer.borderColor = UIColor.darkGray.cgColor
        loadButton.layer.borderWidth = 1.0
        loadButton.setTitle("재시도", for: .normal)
        loadButton.setTitleColor(.darkGray, for: .normal)
        loadButton.addTarget(self, action: #selector(loadButtonTouched), for: .touchUpInside)
        
        self.addSubview(messageLabel)
        self.addSubview(loadButton)

    }
    
    func loadButtonTouched(button:UIButton) {
        delegate.loadButtonTouched(button: button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
