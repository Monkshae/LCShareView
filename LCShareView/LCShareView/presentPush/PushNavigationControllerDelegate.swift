//
//  PushNavigationControllerDelegate.swift
//  LCShareView
//
//  Created by licong on 2017/4/7.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

import UIKit

class NavigationAnimationDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is PushController && operation == .push  {
            return PushAnimation()
        } else if operation == .pop && fromVC is PopController {
            return PopAnimation()
        } else {
            return nil
        }
    }
}
