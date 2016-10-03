//
//  NavigationPushAnimator.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class NavigationPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! FirstCollectionController
        let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! SecondDetailController
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containerView = transitionContext.containerView
        
        let cell = fromController.collectionView .cellForItem(at: (fromController.collectionView.indexPathsForSelectedItems?.first)!) as! ThingCell
        let cellImageSnapshot = cell.imageView?.snapshotView(afterScreenUpdates: false)
        cellImageSnapshot?.frame = (containerView.convert((cell.imageView?.frame)!, from: cell.imageView!.superview))
        
        toView?.frame = transitionContext.finalFrame(for: toController)
        toView?.alpha = 0.0
        toController.imageView.isHidden = true
        containerView.addSubview(toView!)
        containerView.addSubview(cellImageSnapshot!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            toView?.alpha = 1.0
//            let frame = containerView?.convertRect(toController.imageView.frame, fromView: toController.view)
//            cellImageSnapshot?.frame = toController.imageView.frame
             //这里有疑问
             let frame = containerView.convert(toController.imageView.frame, from: toController.view)
            cellImageSnapshot?.frame = frame
        }, completion: { (finished: Bool) in
            
            toController.imageView.isHidden = false
            //pop前提前设置显示为yes
            cell.isHidden = false
            cellImageSnapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }) 
    }
}
