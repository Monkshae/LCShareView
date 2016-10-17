//
//  InteractivityFirstController.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class InteractivityFirstController: UIViewController {
    
    lazy var secondController: InteractivitySecondController = {
        $0.modalPresentationStyle = .fullScreen
        return $0
    }(InteractivitySecondController())
    
    lazy var trasitionDelegate: InteractivityTransitionDelegate = InteractivityTransitionDelegate()
    lazy var trasitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(InteractivityFirstController.interactiveTransitionRecognizerAction(_:)))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // 添加滑动交互手势
        trasitionRecognizer.edges = .right
        self.view.addGestureRecognizer(trasitionRecognizer)
        
        // 设置动画代理
        secondController.transitioningDelegate = trasitionDelegate
    }

    
    func setupView()  {
        view.backgroundColor = UIColor.purple
        navigationItem.title = "交互式动画"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(InteractivityFirstController.leftBarButtonDidClicked))
        let label = UILabel()
        label.text = "From"
        label.font = UIFont(name: "Helvetica", size: 50)
        view.addSubview(label)
        label.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: UIControlState())
        button.setTitle("present", for: UIControlState())
        button.addTarget(self, action: #selector(InteractivityFirstController.animationAction(_:)), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }
    
    
    func leftBarButtonDidClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //在开始触发手势时，调用
    func interactiveTransitionRecognizerAction(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
       
        if gestureRecognizer.state == .began {
            animationAction(gestureRecognizer)
        }
    }
    
    func animationAction(_ sender: AnyObject) {
        if sender is UIGestureRecognizer {
            trasitionDelegate.gestureRecognizer = trasitionRecognizer
        } else {
            trasitionDelegate.gestureRecognizer = nil
        }
        //设置targetEdge为右边，也就是检测从右滑动的手势
        trasitionDelegate.targetEdge = .right
        self.present(secondController, animated: true, completion: nil)
    }
    
}
