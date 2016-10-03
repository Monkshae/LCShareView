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
        $0.modalPresentationStyle = .fullScreen
        //设置转场动画代理
        $0.transitioningDelegate = self
        return $0
    }(CrossDissolveSecondController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "淡入淡出"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(CrossDissolveFirstController.backAction))
        view.backgroundColor = UIColor.red
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
        
        let button = UIButton(type: .custom)
        button.setTitle("present", for: UIControlState())
        button.addTarget(self, action: #selector(CrossDissolveFirstController.aniamtionAction), for: .touchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.bottom.equalTo(view).offset(-50)
        }
    }
    
    func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func aniamtionAction() {
        self.present(secondController, animated: true, completion: nil)
    }
    
}


// MARK: - 实现协议，需提供present和dismiss时的animator，其实有时候present和dismiss可以共用一份animator
extension CrossDissolveFirstController:UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfWaySpringAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimator()
    }
}
