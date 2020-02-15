//
//  FadeAnimationController.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/14.
//  Copyright © 2020 Francis. All rights reserved.
//

import Foundation
import UIKit

class NormalAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let presenting: Bool
    
    init(presenting: Bool) {
        self.presenting = presenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let container = transitionContext.containerView
        
        let toViewWidth = toView.frame.width
        
        if presenting {
            container.addSubview(toView)
            toView.transform = CGAffineTransform(translationX: toViewWidth, y: 0)
            fromView.transform = .identity
        } else {
            container.insertSubview(toView, belowSubview: fromView)
//            toView.transform = CGAffineTransform(translationX: -toViewWidth * 1/3, y: 0)
            toView.transform = CGAffineTransform.identity.translatedBy(x: -toViewWidth * 1/3, y: 0).scaledBy(x: 0.9, y: 0.9)

        }
                
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: {
            if self.presenting {
                toView.transform = .identity
//                fromView.transform = CGAffineTransform(translationX: -toViewWidth * 1/3, y: 0)
                fromView.transform = CGAffineTransform.identity.translatedBy(x: -toViewWidth * 1/3, y: 0).scaledBy(x: 0.9, y: 0.9)
            } else {
                toView.transform = .identity
                fromView.transform = CGAffineTransform(translationX: toViewWidth, y: 0)
            }
        }) { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            toView.transform = .identity
            fromView.transform = .identity
            transitionContext.completeTransition(success)
        }
        
        
    }
}
