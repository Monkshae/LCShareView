//
//  InteractivityFirstController.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class InteractivityFirstController: UIViewController {
    
    lazy var secondController: InteractivitySecondController = InteractivitySecondController()
    lazy var trasitionDelegate: InteractivityTransitionDelegate = InteractivityTransitionDelegate()
    lazy var trasitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(InteractivityFirstController.interactiveTransitionRecognizerAction(_:)))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // 添加滑动交互手势
        trasitionRecognizer.edges = .Right
        self.view.addGestureRecognizer(trasitionRecognizer)
        
        // 设置动画代理
        secondController.transitioningDelegate = trasitionDelegate
        secondController.modalPresentationStyle = .FullScreen
    }

    
    func setupView()  {
        view.backgroundColor = UIColor.purpleColor()
        navigationItem.title = "交互式动画"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InteractivityFirstController.leftBarButtonDidClicked))
        let label = UILabel()
        label.text = "From"
        label.font = UIFont(name: "Helvetica", size: 50)
        view.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        let button = UIButton()
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.setTitle("present", forState: .Normal)
        button.addTarget(self, action: #selector(InteractivityFirstController.animationAction(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }
    
    
    func leftBarButtonDidClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //在开始触发手势时，调用
    func interactiveTransitionRecognizerAction(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
       
        if gestureRecognizer.state == .Began {
            animationAction(gestureRecognizer)
        }
    }
    
    func animationAction(sender: AnyObject) {
        if sender.isKindOfClass(UIGestureRecognizer) {
            trasitionDelegate.gestureRecognizer = trasitionRecognizer
        } else {
            trasitionDelegate.gestureRecognizer = nil
        }
        //设置targetEdge为右边，也就是检测从右滑动的手势
        trasitionDelegate.targetEdge = .Right
        self.presentViewController(secondController, animated: true, completion: nil)
    }
    
    
    
}
