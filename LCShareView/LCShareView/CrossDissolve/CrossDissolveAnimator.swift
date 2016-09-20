//
//  CrossDissolveAnimator.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class CrossDissolveAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let containerView = transitionContext.containerView()
        fromView?.frame = transitionContext.initialFrameForViewController(fromController!)
        toView?.frame = transitionContext.finalFrameForViewController(toViewController!)
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        containerView?.addSubview(toView!)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            fromView?.alpha = 0.0
            toView?.alpha = 1.0
        }) { (finished) in
            let cancelled = transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(!cancelled)
        }
    }
}
