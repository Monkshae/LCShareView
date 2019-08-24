//
//  popController.swift
//  LCShareView
//
//  Created by licong on 2017/4/7.
//  Copyright © 2017年 Sean Lee. All rights reserved.
//

import UIKit

class PopController: UIViewController {

    
    fileprivate var  navDelegate = NavigationAnimationDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        let label = UILabel()
        label.text = "哈哈哈"
        label.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        view.addSubview(label)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItem.Style.plain, target: self, action: #selector(PopController.didButtonClicked(_:)))
    }

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
    
    
    @objc func didButtonClicked(_ sender: UIButton)  {
        navigationController?.popViewController(animated: true)
    }

}
