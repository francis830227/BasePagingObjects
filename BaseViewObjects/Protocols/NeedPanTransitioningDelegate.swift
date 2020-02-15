//
//  NeedPanTransitioningDelegate.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/15.
//  Copyright © 2020 Francis. All rights reserved.
//

import Foundation
import UIKit

protocol NeedPanTransitioningDelegate {
    
    var panTransitioningDelegate: PanTransitioningDelegate { get set }
    
}

extension NeedPanTransitioningDelegate where Self: UIViewController {
    
    func setupTransitioningDelegate(with toPresentViewController: UIViewController) {
        
        toPresentViewController.transitioningDelegate = panTransitioningDelegate
        
        panTransitioningDelegate.addPresentInteractionController(to: self)
        
        panTransitioningDelegate.setupPresentDestination(with: toPresentViewController)
        
    }
    
}
