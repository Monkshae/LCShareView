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
    var edge: UIRectEdge = .None
    
    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging edge: UIRectEdge) {
        super.init()
        assert(edge == .Top || edge == .Bottom || edge == .Left || edge == .Right, "edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        self.gestureRecognizer = gestureRecognizer
        self.edge = edge
        self.gestureRecognizer?.addTarget(self, action: #selector(InteractivityPercentTransition.gestureRecognizeDidUpdate(_:)))
    }
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        self.transitionContext = transitionContext
    }
    
    /// 当手势有滑动时触发这个函数
    func gestureRecognizeDidUpdate(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began: break
        case .Changed: self.updateInteractiveTransition(self.percentForGesture(gestureRecognizer))  //手势滑动，更新百分比
        case .Ended:    // 滑动结束，判断是否超过一半，如果是则完成剩下的动画，否则取消动画
            if self.percentForGesture(gestureRecognizer) >= 0.5 {
                self.finishInteractiveTransition()
            }
            else {
                self.cancelInteractiveTransition()
            }
            default: self.cancelInteractiveTransition()
        }
    }
    
    private func percentForGesture(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let transitionContainerView = transitionContext?.containerView()
        let location = gesture.locationInView(transitionContainerView)
        let width = transitionContainerView?.bounds.width
        let height = transitionContainerView?.bounds.height
        switch self.edge {
        case UIRectEdge.Right: return (width! - location.x) / width!
        case UIRectEdge.Left: return location.x / width!
        case UIRectEdge.Bottom: return (height! - location.y) / height!
        case UIRectEdge.Top: return location.y / height!
        default: return 0
        
        
    }
    
    }
}
