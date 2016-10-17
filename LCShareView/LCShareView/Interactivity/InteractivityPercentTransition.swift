//
//  InteractivityPercentTransition.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class InteractivityPercentTransition: UIPercentDrivenInteractiveTransition {
    var transitionContext: UIViewControllerContextTransitioning?
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer?
    var edge: UIRectEdge = UIRectEdge()
    
    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging edge: UIRectEdge) {
        super.init()
        assert(edge == .top || edge == .bottom || edge == .left || edge == .right, "edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        self.gestureRecognizer = gestureRecognizer
        self.edge = edge
        self.gestureRecognizer?.addTarget(self, action: #selector(InteractivityPercentTransition.gestureRecognizeDidUpdate(_:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        self.transitionContext = transitionContext
    }
    
    /// 当手势有滑动时触发这个函数
    func gestureRecognizeDidUpdate(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began: break
        case .changed: self.update(self.percentForGesture(gestureRecognizer))  //手势滑动，更新百分比
        case .ended:    // 滑动结束，判断是否超过一半，如果是则完成剩下的动画，否则取消动画
            if self.percentForGesture(gestureRecognizer) >= 0.5 {
                self.finish()
            }
            else {
                self.cancel()
            }
        default: self.cancel()
        }
    }
    
    fileprivate func percentForGesture(_ gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let transitionContainerView = transitionContext?.containerView
        //locationInView获取到的是手指点击屏幕实时的坐标点
        let location = gesture.location(in: transitionContainerView)
        let width = transitionContainerView?.bounds.width
        let height = transitionContainerView?.bounds.height
        switch self.edge {
        case UIRectEdge.right: return (width! - location.x) / width!
        case UIRectEdge.left: return location.x / width!
        case UIRectEdge.bottom: return (height! - location.y) / height!
        case UIRectEdge.top: return location.y / height!
        default: return 0
        
        
    }
    
    }
}
