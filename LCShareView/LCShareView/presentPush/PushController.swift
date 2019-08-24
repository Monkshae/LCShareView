//
//  ViewController.swift
//  PushAnimation
//
//  Created by licong on 2017/4/10.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class PushController: UIViewController {

    //这是toViewController
    lazy var popController: PopController = {
        return $0
    }(PopController())
    
    
    fileprivate var  navDelegate = NavigationAnimationDelegate()
    
    //navigationController是共有的，离开页面后记得置空
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //将自己设置为naviagation controller 的代理，以便于做转场动画
        navigationController?.delegate = navDelegate
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //离开页面后将delegate置空
        if navigationController?.delegate != nil {
            navigationController?.delegate = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 224/255, green: 222/255, blue: 1, alpha: 1)
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: UIControl.State())
        button.setTitle("演示动画", for: UIControl.State())
        button.addTarget(self, action: #selector(PushController.animationButtonDidClicked), for: .touchUpInside)
        view.addSubview(button)
        button.frame = CGRect(x: 80, y: 400, width: 200, height: 60)
    }
    
    @objc func animationButtonDidClicked() {
        navigationController?.pushViewController(popController, animated: true)
    }
    
    func leftBarButtonDidClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}

