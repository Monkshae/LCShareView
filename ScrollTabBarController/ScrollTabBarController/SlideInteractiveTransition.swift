//
//  SlideInteractiveTransition.swift
//  ScrollTabBarController
//
//  Created by licong on 16/9/28.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class SlideInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var panGesture: UIPanGestureRecognizer?
    var tabBarController: UITabBarController?
    private var transitionContext: UIViewControllerContextTransitioning?
    private var subViewControllerCount: Int {
        let count  = tabBarController?.viewControllers != nil ? tabBarController?.viewControllers?.count : 0
        return count!
    }
    
    init(gesture: UIPanGestureRecognizer, tabBarController: UITabBarController) {
        super.init()
        panGesture = gesture
        self.tabBarController = tabBarController
        panGesture?.addTarget(self, action: #selector(SlideInteractiveTransition.gestureRecognizerDidUpdate(_:)))
    }
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        self.transitionContext = transitionContext
    }
    
    func gestureRecognizerDidUpdate(gesture: UIPanGestureRecognizer) {
        let transitionContainerView = transitionContext?.containerView()
        let transitionX  = panGesture?.translationInView(transitionContainerView).x
        //获取到的是手指移动后，在相对于self.view坐标中的偏移量
        let translationAbs = abs(transitionX!)
        let progress = translationAbs / (transitionContainerView?.frame.width)!
        switch gesture.state {
        case .Began:
            //x方向的速度
            let velocityX = gesture.velocityInView(transitionContainerView).x
            if  velocityX < 0 {
                if tabBarController?.selectedIndex < subViewControllerCount  - 1 {
                    tabBarController?.selectedIndex += 1
                } else {
                    if tabBarController?.selectedIndex > 0 {
                        tabBarController?.selectedIndex -= 1
                    }
                }
                
            }
        case .Changed: self.updateInteractiveTransition(progress)
        case .Cancelled, .Ended:
            if progress > 0.3 {
                //这里设置成0.99是为了 结局转场结束或是取消时有很大几率出现动画不正常的问题，详见//https://github.com/seedante/iOS-ViewController-Transition-Demo中的demo
                self.completionSpeed = 0.99
                self.finishInteractiveTransition()
            } else {
                //转场取消后,UITableBarController自动恢复了 selectedIndex的值,不需要我们手动恢复
                self.completionSpeed = 0.99
                self.cancelInteractiveTransition()
            }            
        default: break
        }
        
    }
}
