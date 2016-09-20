//
//  HalfWaySpringAnimator.swift
//  LCShareView
//
//  Created by licong on 16/9/19.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class HalfWaySpringAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    //设置动画持续时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2
    }
    
    //设置动画的进行方式
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let finalControllerFrame = transitionContext.finalFrameForViewController(toController!)
        let containerView = transitionContext.containerView()
        
        /* 需要关注一下from/to和presented/presenting的关系
         For a Presentation:
              fromView = The presenting view.
              toView   = The presented view.
         For a Dismissal:
              fromView = The presented view.
             toView   = The presenting view.
         */
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        // 我们让toview的origin.y在屏幕的一半处，这样它从屏幕的中间位置弹起而不是从屏幕底部弹起，弹起过程中逐渐变为不透明
        toView?.frame = CGRectMake(fromView!.frame.origin.x, fromView!.frame.maxY / 2, fromView!.frame.width, fromView!.frame.height)
        toView?.alpha = 0.0
        //这一步很重要，必须将toView添加到试图层次中
        containerView?.addSubview(toView!)
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveLinear, animations: {
            toView?.alpha = 1
            toView?.frame = finalControllerFrame
        }) { (finished: Bool) in
            let cancelled = transitionContext.transitionWasCancelled()
            //这句话必须要，如果取消了就设置为NO，反之，设置为YES
            transitionContext.completeTransition(!cancelled)
        }
        
        
    }
    
}
