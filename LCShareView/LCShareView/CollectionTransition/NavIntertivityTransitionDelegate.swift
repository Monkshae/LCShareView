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

    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer?) {
        self.gestureRecognizer = gestureRecognizer
    }
    
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is FirstCollectionController && operation == .Push  {
            return NavigationPushAnimator()
        } else if operation == .Pop && fromVC is SecondDetailController {
            return NavigationPopAnimation()
        } else {
            return nil
        }
    }
    
    
//    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        
//        return    ExpandTransition(gestureRecognizer: gestureRecognizer)
//        
//    }
    
}
