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
    
    
    //push 和pop 转场动画
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is FirstCollectionController && operation == .push  {
            return NavigationPushAnimator()
        } else if operation == .pop && fromVC is SecondDetailController {
            return NavigationPopAnimation()
        } else {
            return nil
        }
    }
    
    
    //交互动画
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //push动画没有手势，这里的就是个demo，不是严谨的判断
        if gestureRecognizer != nil {
            return  ExpandTransition(gestureRecognizer: gestureRecognizer)
        }
        return nil
    }
    
}
