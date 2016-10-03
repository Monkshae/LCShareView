//
//  NavigationPopAnimation.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class NavigationPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! SecondDetailController
        let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! FirstCollectionController
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)

        let containerView = transitionContext.containerView
        
        let imageSnapshot = fromController.imageView.snapshotView(afterScreenUpdates: false)
        imageSnapshot?.frame = (containerView.convert(fromController.imageView.frame, from: fromController.imageView.superview))
        fromController.imageView.isHidden = true
        
        let cell = toController.collectionViewCellForThing(fromController.thing!)
        cell?.imageView?.isHidden = true
        
        toView?.frame = transitionContext.finalFrame(for: toController)
        containerView.insertSubview(toView!, belowSubview: fromView!)
        containerView.addSubview(imageSnapshot!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            fromView?.alpha = 0.0
            imageSnapshot?.frame = (containerView.convert((cell?.imageView!.frame)!, from: cell?.imageView!.superview))
        }, completion: { (finished: Bool) in
            //此时截图和cell的image已经一样大了，就删除视觉上的snapshot
            imageSnapshot?.removeFromSuperview()
            cell?.imageView?.isHidden = false
            //这句话不写，当手势交互的时候，先返回后取消返回会发现SecondController的图片不见了。因为即使最后交互取消了，这句话仍然是执行了。
            fromController.imageView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }) 
        
    }
}
