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
    var transitionContext: UIViewControllerContextTransitioning?
    
    init(gesture: UIPanGestureRecognizer) {
        super.init()
        panGesture = gesture
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
    }
}
