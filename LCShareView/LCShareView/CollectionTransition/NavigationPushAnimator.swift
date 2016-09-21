//
//  NavigationPushAnimator.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class NavigationPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FirstCollectionController
        let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! SecondDetailController
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let containerView = transitionContext.containerView()
        
        let cell = fromController.collectionView .cellForItemAtIndexPath((fromController.collectionView.indexPathsForSelectedItems()?.first)!) as! ThingCell
        let cellImageSnapshot = cell.imageView?.snapshotViewAfterScreenUpdates(false)
        cellImageSnapshot?.frame = (containerView?.convertRect((cell.imageView?.frame)!, fromView: cell.imageView!.superview))!
        
        toView?.frame = transitionContext.finalFrameForViewController(toController)
        toView?.alpha = 0.0
        toController.imageView.hidden = true
        containerView?.addSubview(toView!)
        containerView?.addSubview(cellImageSnapshot!)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            toView?.alpha = 1.0
//            let frame = containerView?.convertRect(toController.imageView.frame, fromView: toController.view)
            cellImageSnapshot?.frame = toController.imageView.frame
        }) { (finished: Bool) in
            
            toController.imageView.hidden = false
            //pop前提前设置显示为yes
//            cell.hidden = false
            cellImageSnapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
