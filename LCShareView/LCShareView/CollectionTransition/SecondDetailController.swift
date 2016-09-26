//
//  SecondDetailController.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class SecondDetailController: UIViewController {

    var imageView: UIImageView = {
        let  imageView = UIImageView(frame: CGRectMake(60, 60, 200, 200))
        return imageView
    }()
    
    var overviewLabel:UILabel = {
        let label = UILabel(frame: CGRectMake(60, 60, 200, 30))
        label.font = UIFont(name: "Helvetica", size: 60)
        return label
    }()
    var thing: Thing? {
        didSet{
            imageView.image = thing?.image
        }
    }

    lazy var navTransitionRecognizer: UIScreenEdgePanGestureRecognizer = {
       let gestureRecognizer =  UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(InteractivitySecondController.animationAction(_:)))
        gestureRecognizer.edges = .Left
        return gestureRecognizer
    }()
//    private var transition: ExpandTransition?
    private var  navDelegate = NavIntertivityTransitionDelegate(gestureRecognizer: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x3A/255, green: 0xDB/255, blue: 0xD2/255, alpha: 1)
        view.addSubview(imageView)
        view.addSubview(overviewLabel)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InteractivityFirstController.animationAction(_:)))
        view.addGestureRecognizer(navTransitionRecognizer)
//        transition = ExpandTransition(gestureRecognizer: navTransitionRecognizer)
        navigationController?.delegate = navDelegate
    }

    
    func animationAction(gestureRecongizer: UIScreenEdgePanGestureRecognizer) {
        
//        if gestureRecongizer.isKindOfClass(UIGestureRecognizer) {
//            navDelegate.gestureRecognizer = navTransitionRecognizer
//        } else {
//            navDelegate.gestureRecognizer = nil
//        }
        
        //这句话开始后执行转场动画
        navigationController?.popViewControllerAnimated(true)
    }
}

//
//extension SecondDetailController: UINavigationControllerDelegate {
//    
//    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if fromVC == self && toVC is FirstCollectionController {
//            return  NavigationPopAnimation()
//        }else {
//            return nil
//        }
//    }
//    
//    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        
//        if transitioningDelegate as? NavIntertivityTransitionDelegate != nil {
//            return transition
//        } else{
//            return nil
//        }
//
//    }
//}