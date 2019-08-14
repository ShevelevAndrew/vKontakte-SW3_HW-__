//
//  CustomNavigationController2.swift
//  vKontakte
//
//  Created by Andrew on 20/06/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class CustomNavigationController2: UINavigationController, UINavigationControllerDelegate {
    let transitionAnimator = AnimatorPush()
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let edgeSwipeGP = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenGesture(_:)))
        edgeSwipeGP.edges = .left
        view.addGestureRecognizer(edgeSwipeGP)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            return PushAnimator()
        case .pop:
            return PopAnimator()
        case .none:
            return nil
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc func handleScreenGesture (_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
            
        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTraslation = translation.x / width
            let progress = max(0, min(1, relativeTraslation))
            
            interactiveTransition.shouldFinish = progress > 0.4
            interactiveTransition.update(progress)
            
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
            
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
            
        default:
            break
        }
    }
    
}
