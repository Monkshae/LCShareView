//
//  InteractiveSecondController.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class InteractivitySecondController: UIViewController {

    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(self.animationAction(sender:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // 主要是一些UI控件的布局，可以无视其实现细节
        /// 添加滑动交互手势
        interactiveTransitionRecognizer.edges = .left
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    
    func setupView()  {
        view.backgroundColor = UIColor.green
        navigationItem.title = "Second"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItem.Style.plain, target: self, action: #selector(InteractivityFirstController.animationAction(_:)))
        let label = UILabel()
        label.text = "To"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 50)
        view.addSubview(label)
        label.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("dismiss", for: .normal)
        button.addTarget(self, action: #selector(self.animationAction(sender:)), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
    }

    
    @objc func animationAction(sender: UIScreenEdgePanGestureRecognizer?) {
        if sender?.state == .began {
            self.buttonDidClicked(sender: sender!)
        }
    }
    
    func buttonDidClicked(sender: AnyObject) {
        // 和FirstViewController中的代码是类似的，不过返回时手势应该是从左向右
        if let transitionDelegate = self.transitioningDelegate as? InteractivityTransitionDelegate {
            if sender is UIGestureRecognizer {
                transitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
            }
            else {
                transitionDelegate.gestureRecognizer = nil
            }
            transitionDelegate.targetEdge = .left
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
