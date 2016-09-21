//
//  CustomFirstController.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class CustomFirstController: UIViewController {

    //这是toViewController
    lazy var secondController: CustomSecondController = CustomSecondController()
    
    lazy var customPresentationController: CustomPresentationController = CustomPresentationController(presentedViewController: self.secondController, presentingViewController: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        secondController.transitioningDelegate = customPresentationController
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 224/255, green: 222/255, blue: 1, alpha: 1)
        /// 设置navigationItem
        navigationItem.title = "自定义Presentation"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CustomFirstController.leftBarButtonDidClicked))
        
        // 创建label
        let label = UILabel()
        label.text = "From"
        label.font = UIFont(name: "Helvetica", size: 60)
        view.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
        /// 创建button
        let button = UIButton()
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.setTitle("演示动画", forState: .Normal)
        button.addTarget(self, action: #selector(CustomFirstController.animationButtonDidClicked), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }

    func animationButtonDidClicked() {
        self.presentViewController(secondController, animated: true, completion: nil)
    }
    
    func leftBarButtonDidClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}