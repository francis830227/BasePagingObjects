//
//  RightViewController.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/14.
//  Copyright © 2020 Francis. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        label.font = UIFont.systemFont(ofSize: 40)
        
        label.text = "Right\nView\nController"
        
        label.textAlignment = .center
        
        label.numberOfLines = 0
        
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = view.bounds
    }
    
}
