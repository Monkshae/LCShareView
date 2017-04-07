//
//  PushNavigationControllerDelegate.swift
//  LCShareView
//
//  Created by licong on 2017/4/7.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

import UIKit

class PushNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is PushController && operation == .push  {
            return PushAnimation()
        } else if operation == .pop && fromVC is PopController {
            return PopAnimation()
        } else {
            return nil
        }
    }
    
}
