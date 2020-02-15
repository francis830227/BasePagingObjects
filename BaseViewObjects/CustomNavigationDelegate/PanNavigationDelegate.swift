//
//  PanNavigationDelegate.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/14.
//  Copyright © 2020 Francis. All rights reserved.
//

import Foundation
import UIKit

class PanNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    private var interactionController: UIPercentDrivenInteractiveTransition?
    private var current: UIViewController?
    private var pushDestination: UIViewController?
    
    func setupPushDestination(with viewController: UIViewController) {
        pushDestination = viewController
        addPopInteractionControllerToPushDestination()
    }
    
    private func addPopInteractionControllerToPushDestination() {
        guard let vc = pushDestination else { return }
        addPopInteractionController(to: vc.view)
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return NormalAnimationController(presenting: true)
        } else {
            return NormalAnimationController(presenting: false)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        current = viewController
    }
    
}

// push
extension PanNavigationDelegate {
    func addPushInteractionController(to view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePushGesture(_:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePushGesture(_ gesture: UIPanGestureRecognizer) {

        let position = gesture.translation(in: gesture.view)
        let percentComplete = min(-position.x / gesture.view!.bounds.width, 1.0)

        switch gesture.state {
        case .began:
            interactionController = UIPercentDrivenInteractiveTransition()
            guard let controller = pushDestination else { return }
            current?.navigationController?.pushViewController(controller, animated: true)

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
extension PanNavigationDelegate {
    private func addPopInteractionController(to view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePopGesture(_:)))
        view.addGestureRecognizer(pan)
    }

    @objc private func handlePopGesture(_ gesture: UIPanGestureRecognizer) {
        let position = gesture.translation(in: gesture.view)
        let percentComplete = min(position.x / gesture.view!.bounds.width, 1)

        switch gesture.state {
        case .began:
            interactionController = UIPercentDrivenInteractiveTransition()
            current?.navigationController?.popViewController(animated: true)

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
