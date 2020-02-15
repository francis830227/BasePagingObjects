//
//  DemoCollectionViewCell.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/15.
//  Copyright © 2020 Francis. All rights reserved.
//

import UIKit

class DemoCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        label.frame = bounds
    }
    
    func setupView() {
        
        label.textAlignment = .center
        
        label.font = UIFont.systemFont(ofSize: 30)
        
        addSubview(label)
        
        backgroundColor = UIColor(red: CGFloat.random(in: 0 ..< 1), green: CGFloat.random(in: 0 ..< 1), blue: CGFloat.random(in: 0 ..< 1), alpha: 1)
        
    }
    
}
