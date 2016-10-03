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
    var targetEdge:  UIRectEdge = UIRectEdge()
    init(targetEdge: UIRectEdge) {
// 当我们重写一个类的构造方法时, 系统内部会悄悄的帮我们调用super.init(),以下这一句代码, 能不写就不写
//        super.init()
        self.targetEdge = targetEdge
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containerView = transitionContext.containerView
        
        //isPresent用于判断当前是present还是dismiss
        let isPresent = toViewController?.presentingViewController == fromViewController
        let fromFrame = transitionContext.initialFrame(for: fromViewController!)
        let toFrame = transitionContext.finalFrame(for: toViewController!)
        
        //offset结构体用于计算toView的位置
        var  offset: CGVector
        switch targetEdge {
        case UIRectEdge.top: offset = CGVector(dx: 0, dy: 1)
        case UIRectEdge.bottom: offset = CGVector(dx: 0, dy: -1)
        case UIRectEdge.left: offset = CGVector(dx: -1, dy: 0)
        case UIRectEdge.right: offset = CGVector(dx: 1, dy: 0)
        default:
            fatalError("targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        }
        
        if isPresent {
//            fromView?.frame = fromFrame
            toView?.frame = toFrame.offsetBy(dx: toFrame.width * offset.dx, dy: toFrame.height * offset.dy)
            containerView.addSubview(toView!)
        } else {
//            fromView?.frame = fromFrame
            toView?.frame = toFrame
            //这里需要注意不能用containerView?.addSubview(toView!)           
            containerView.insertSubview(toView!, belowSubview: fromView!)

        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            if isPresent {
                toView?.frame = toFrame
            } else {
                fromView?.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx * -1,
                    dy: fromFrame.size.height * offset.dy * -1)
            }
            }, completion: { (finished) in
                let canceled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!canceled)
        }) 
        
    }
    
}
