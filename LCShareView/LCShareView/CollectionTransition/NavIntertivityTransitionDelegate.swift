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
    
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //push动画没有手势，这里的就是个demo，不是严谨的判断
        if gestureRecognizer != nil {
            return  ExpandTransition(gestureRecognizer: gestureRecognizer)
        }
        return nil
    }
    
}
