//
//  PanTransitioningDelegate.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/15.
//  Copyright © 2020 Francis. All rights reserved.
//

import Foundation
import UIKit

class PanTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private var interactionController: UIPercentDrivenInteractiveTransition?
    
    private var presentDestination: UIViewController?
    
    private var source: UIViewController?
    
    func setupPresentDestination(with viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        presentDestination = viewController
        addDismissInteractionControllerToPresentDestination()
    }
    
    private func addDismissInteractionControllerToPresentDestination() {
        guard let vc = presentDestination else { return }
        addDismissInteractionController(to: vc.view)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NormalAnimationController(presenting: false)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NormalAnimationController(presenting: true)
    }
}

// push
extension PanTransitioningDelegate {
    func addPresentInteractionController(to viewController: UIViewController) {
        source = viewController
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePresentGesture(_:)))
        viewController.view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePresentGesture(_ gesture: UIPanGestureRecognizer) {

        let position = gesture.translation(in: gesture.view)
        let percentComplete = min(-position.x / gesture.view!.bounds.width, 1.0)

        switch gesture.state {
        case .began:
            interactionController = UIPercentDrivenInteractiveTransition()
            guard let presentedController = presentDestination, let sourceController = source else { return }
            sourceController.present(presentedController, animated: true, completion: nil)
            
        case .changed:
            interactionController?.update(percentComplete)

        case .ended, .cancelled:
            let speed = gesture.velocity(in: gesture.view)
            if speed.x < 0 || (speed.x == 0 && percentComplete > 0.5) {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil

        default:
            break
        }
    }
}


// pop
extension PanTransitioningDelegate {
    private func addDismissInteractionController(to view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleDismissGesture(_:)))
        view.addGestureRecognizer(pan)
    }

    @objc private func handleDismissGesture(_ gesture: UIPanGestureRecognizer) {
        let position = gesture.translation(in: gesture.view)
        let percentComplete = min(position.x / gesture.view!.bounds.width, 1)

        switch gesture.state {
        case .began:
            interactionController = UIPercentDrivenInteractiveTransition()
             guard let controller = presentDestination else { return }
            controller.dismiss(animated: true, completion: nil)

        case .changed:
            interactionController?.update(percentComplete)

        case .ended, .cancelled:
            let speed = gesture.velocity(in: gesture.view)
            if speed.x > 0 || (speed.x == 0 && percentComplete > 0.5) {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil

        default:
            break
        }
    }
}
