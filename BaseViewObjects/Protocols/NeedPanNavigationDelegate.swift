//
//  NeedPanNavigationDelegate.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/15.
//  Copyright © 2020 Francis. All rights reserved.
//

import Foundation
import UIKit

protocol NeedPanNavigationDelegate {
    
    var navigationDelegate: PanNavigationDelegate { get set }
    
}

extension NeedPanNavigationDelegate where Self: UIViewController {
        
    func setupNavigationDelegate(with toPushViewController: UIViewController) {
        
        navigationController?.delegate = navigationDelegate
        
        navigationDelegate.addPushInteractionController(to: view)
        
        navigationDelegate.setupPushDestination(with: toPushViewController)
    
    }
    
}
