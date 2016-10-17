//
//  CrossDissolveSecondController.swift
//  LCShareView
//
//  Created by licong on 16/9/19.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class CrossDissolveSecondController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        setupView()
    }
    
    func setupView() {
        let button = UIButton(type: .custom)
        button.setTitle("dismiss", for: UIControlState())
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(CrossDissolveSecondController.aniamtionAction), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func aniamtionAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
