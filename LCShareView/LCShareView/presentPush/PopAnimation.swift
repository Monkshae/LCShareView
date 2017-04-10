//
//  PopAnimation.swift
//  LCShareView
//
//  Created by licong on 2017/4/7.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! PushController
        let containerView = transitionContext.containerView
        let toViewFinalFrame = transitionContext.finalFrame(for: toController)

        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        if toView != nil {
            containerView.addSubview(toView!)
            containerView.addSubview(fromView!)
        }
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView?.frame = toViewFinalFrame
            fromView?.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: { (finished: Bool) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }) 
        
    }
}
