
//
//  NavigationDelegate.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

//手指滑动返回动画
class ExpandTransition: UIPercentDrivenInteractiveTransition {
    
    var transitionContext: UIViewControllerContextTransitioning?
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer?
    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer?) {
        super.init()
        self.gestureRecognizer = gestureRecognizer
        self.gestureRecognizer?.addTarget(self, action: #selector(ExpandTransition.gestureRecognizeDidUpdate(_:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        self.transitionContext = transitionContext
    }
    
    
    func gestureRecognizeDidUpdate(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        let transitionContainerView = transitionContext?.containerView
        if transitionContainerView != nil {
            //获取到的是手指移动后，在相对于self.view坐标中的偏移量
            var progress =  recognizer.translation(in: transitionContainerView).x / transitionContainerView!.bounds.width
            print("progress = \(progress)")
            progress = min(1.0, max(0.0, progress))
            switch recognizer.state {
            case .began: break
            case .changed: self.update(progress)  //手势滑动，更新百分比
            case .ended:
                if progress >= 0.5 {
                    self.finish()
                }
                else {
                    self.cancel()
                }
            default:
                self.cancel()
            }
        }
       
     }
    
}
