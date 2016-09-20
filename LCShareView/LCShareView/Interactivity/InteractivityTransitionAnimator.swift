//
//  InteractivityTransitionAnimator.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class InteractivityTransitionAnimator: NSObject,UIViewControllerAnimatedTransitioning {

    //用来判断方向的
    var targetEdge:  UIRectEdge = .None
    init(targetEdge: UIRectEdge) {
        super.init()
        self.targetEdge = targetEdge
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let containerView = transitionContext.containerView()
        
        //isPresent用于判断当前是present还是dismiss
        let isPresent = toViewController?.presentingViewController == fromViewController
        let fromFrame = transitionContext.initialFrameForViewController(fromViewController!)
        let toFrame = transitionContext.finalFrameForViewController(toViewController!)
        
        //offset结构体用于计算toView的位置
        var  offset: CGVector
        switch targetEdge {
        case UIRectEdge.Top: offset = CGVectorMake(0, 1)
        case UIRectEdge.Bottom: offset = CGVectorMake(0, -1)
        case UIRectEdge.Left: offset = CGVectorMake(-1, 0)
        case UIRectEdge.Right: offset = CGVectorMake(1, 0)
        default:
            fatalError("targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        }
        
        if isPresent {
            fromView?.frame = fromFrame
            toView?.frame = CGRectOffset(toFrame, toFrame.width * offset.dx, toFrame.height * offset.dy)
            containerView?.addSubview(toView!)
        } else {
            fromView?.frame = fromFrame
            toView?.frame = toFrame
            //这里需要注意不能用containerView?.addSubview(toView!)           
            containerView!.insertSubview(toView!, belowSubview: fromView!)

        }
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            if isPresent {
                toView?.frame = toFrame
            } else {
                fromView?.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx * -1,
                    fromFrame.size.height * offset.dy * -1)
            }
            }) { (finished) in
                let canceled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!canceled)
        }
        
    }
    
}
