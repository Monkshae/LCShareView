//
//  navIntertivityTransitionDelegate.swift
//  LCShareView
//
//  Created by licong on 16/9/23.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class NavIntertivityTransitionDelegate: NSObject, UINavigationControllerDelegate {

    var gestureRecognizer: UIScreenEdgePanGestureRecognizer? = nil

    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        self.gestureRecognizer = gestureRecognizer
    }
    
    //用于实现交互式动画
//    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        if let gestureRecognizer = self.gestureRecognizer {
//            return ExpandTransition(gestureRecognizer: gestureRecognizer)
//        }
//        return nil
//    }
//    
//    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        if let gestureRecognizer = self.gestureRecognizer {
//            return ExpandTransition(gestureRecognizer: gestureRecognizer)
//        }
//        return nil
//    }
    
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {

    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC == self && toVC is FirstCollectionController {
            return  NavigationPopAnimation()
        }else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return    ExpandTransition(gestureRecognizer: gestureRecognizer)
        
    }
    
}
