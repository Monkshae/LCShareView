//
//  PushController.swift
//  LCShareView
//
//  Created by licong on 2017/4/7.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

import UIKit

class PushController: UIViewController {

    
    //这是toViewController
    lazy var popController: PopController = {
        return $0
    }(PopController())
    

    fileprivate var  navDelegate = PushNavigationControllerDelegate()

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
        /// 设置navigationItem
        navigationItem.title = "自定义Presentation"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PushController.leftBarButtonDidClicked))
        
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: UIControlState())
        button.setTitle("演示动画", for: UIControlState())
        button.addTarget(self, action: #selector(PushController.animationButtonDidClicked), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(250)
            make.height.equalTo(60)
            make.bottom.equalTo(view).offset(-40)
        }
        // Do any additional setup after loading the view.
    }

    func animationButtonDidClicked() {
        navigationController?.pushViewController(popController, animated: true)
    }
    
    func leftBarButtonDidClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}


extension PushController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is PushController && toVC is PopController {
            return  NavigationPushAnimator()
        }else {
            return nil
        }
    }
}

