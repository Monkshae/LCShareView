//
//  CrossDissolveFirstController.swift
//  LCShareView
//
//  Created by licong on 16/9/19.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class CrossDissolveFirstController: UIViewController {

    lazy var secondController:CrossDissolveSecondController = {
        let  controller =  CrossDissolveSecondController()
        controller.modalPresentationStyle = .FullScreen
        controller.transitioningDelegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "淡入淡出"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: #selector(CrossDissolveFirstController.backAction))
        view.backgroundColor = UIColor.redColor()
        setupView()
    }

    func setupView() {
        view.backgroundColor = UIColor(red: 224/255, green: 222/255, blue: 1, alpha: 1)
        
        let label = UILabel()
        label.text = "From"
        label.font = UIFont(name: "Helvetica", size: 50)
        view.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        let button = UIButton(type: .Custom)
        button.setTitle("present", forState: .Normal)
        button.addTarget(self, action: #selector(CrossDissolveFirstController.aniamtionAction), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.bottom.equalTo(view).offset(-50)
        }
    }
    
    func backAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func aniamtionAction() {
        self.presentViewController(secondController, animated: true, completion: nil)
    }
    
}


// MARK: - 实现协议，需提供present和dismiss时的animator，其实有时候present和dismiss可以共用一份animator
extension CrossDissolveFirstController:UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfWaySpringAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimator()
    }
}
