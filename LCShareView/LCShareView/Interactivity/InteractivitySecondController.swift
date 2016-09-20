//
//  InteractiveSecondController.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class InteractivitySecondController: UIViewController {

    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(InteractivitySecondController.animationAction(_:)))


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // 主要是一些UI控件的布局，可以无视其实现细节
        
        /// 添加滑动交互手势
        interactiveTransitionRecognizer.edges = .Left
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    
    
    func setupView()  {
        view.backgroundColor = UIColor.greenColor()
        navigationItem.title = "Second"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InteractivityFirstController.animationAction(_:)))
        let label = UILabel()
        label.text = "To"
        label.textAlignment = .Center
        label.font = UIFont(name: "Helvetica", size: 50)
        view.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        
        let button = UIButton()
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.setTitle("dismiss", forState: .Normal)
        button.addTarget(self, action: #selector(InteractivityFirstController.animationAction(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }

    
    func animationAction(sender: AnyObject) {
        if sender.state == .Began {
            self.buttonDidClicked(sender)
        }
    }
    
    func buttonDidClicked(sender: AnyObject) {
        // 和FirstViewController中的代码是类似的，不过返回时手势应该是从左向右
        if let transitionDelegate = self.transitioningDelegate as? InteractivityTransitionDelegate {
            if sender.isKindOfClass(UIGestureRecognizer) {
                transitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
            }
            else {
                transitionDelegate.gestureRecognizer = nil
            }
            transitionDelegate.targetEdge = .Left
        }
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
