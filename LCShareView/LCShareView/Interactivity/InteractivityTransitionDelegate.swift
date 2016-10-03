//
//  InteractivityTransitionDelegate.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

//这里将delegate单独作为一个文件，主要是为了解耦，能让controller少一些方法
class InteractivityTransitionDelegate: NSObject,UIViewControllerTransitioningDelegate {
    
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer? = nil
    var targetEdge: UIRectEdge = UIRectEdge()
    
    //普通的非交互过度动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return InteractivityTransitionAnimator(targetEdge: targetEdge)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return InteractivityTransitionAnimator(targetEdge: targetEdge)
    }
    
    //用于实现交互式动画
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestrueRecognizer = self.gestureRecognizer {
            return InteractivityPercentTransition(gestureRecognizer: gestrueRecognizer, edgeForDragging: targetEdge)
        }
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestrueRecognizer = self.gestureRecognizer {
            return InteractivityPercentTransition(gestureRecognizer: gestrueRecognizer, edgeForDragging: targetEdge)
        }
        return nil
    }
    
}
