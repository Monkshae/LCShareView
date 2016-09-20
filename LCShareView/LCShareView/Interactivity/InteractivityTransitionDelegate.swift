//
//  InteractivityTransitionDelegate.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class InteractivityTransitionDelegate: NSObject,UIViewControllerTransitioningDelegate {
    
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer? = nil
    var targetEdge: UIRectEdge = .None
    
    //普通的非交互过度动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return InteractivityTransitionAnimator(targetEdge: targetEdge)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return InteractivityTransitionAnimator(targetEdge: targetEdge)
    }
    
    //用于实现交互式动画
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestrueRecognizer = self.gestureRecognizer {
            return InteractivityPercentTransition(gestureRecognizer: gestrueRecognizer, edgeForDragging: targetEdge)
        }
        return nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestrueRecognizer = self.gestureRecognizer {
            return InteractivityPercentTransition(gestureRecognizer: gestrueRecognizer, edgeForDragging: targetEdge)
        }
        return nil
    }
    
}
