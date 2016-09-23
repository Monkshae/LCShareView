//
//  navIntertivityTransitionDelegate.swift
//  LCShareView
//
//  Created by licong on 16/9/23.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class NavIntertivityTransitionDelegate: NSObject,UIViewControllerTransitioningDelegate {

    var gestureRecognizer: UIScreenEdgePanGestureRecognizer? = nil

    //用于实现交互式动画
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = self.gestureRecognizer {
            return ExpandTransition(gestureRecognizer: gestureRecognizer)
        }
        return nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = self.gestureRecognizer {
            return ExpandTransition(gestureRecognizer: gestureRecognizer)
        }
        return nil
    }
    
    
}
