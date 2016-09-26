//
//  NavigationPopAnimation.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class NavigationPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! SecondDetailController
        let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! FirstCollectionController
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)

        let containerView = transitionContext.containerView()
        
        let imageSnapshot = fromController.imageView.snapshotViewAfterScreenUpdates(false)
        imageSnapshot.frame = (containerView?.convertRect(fromController.imageView.frame, fromView: fromController.imageView.superview))!
        fromController.imageView.hidden = true
        
        let cell = toController.collectionViewCellForThing(fromController.thing!)
        cell?.imageView?.hidden = true
        
        toView?.frame = transitionContext.finalFrameForViewController(toController)
        containerView?.insertSubview(toView!, belowSubview: fromView!)
        containerView?.addSubview(imageSnapshot)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            fromView?.alpha = 0.0
            imageSnapshot.frame = (containerView?.convertRect((cell?.imageView!.frame)!, fromView: cell?.imageView!.superview))!
        }) { (finished: Bool) in
            //此时截图和cell的image已经一样大了，就删除视觉上的snapshot
            imageSnapshot.removeFromSuperview()
            cell?.imageView?.hidden = false
            //这句话不写，当手势交互的时候，先返回后取消返回会发现SecondController的图片不见了。因为即使最后交互取消了，这句话仍然是执行了。
            fromController.imageView.hidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
}
