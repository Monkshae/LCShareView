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
        view.backgroundColor = UIColor.purpleColor()
        setupView()
    }
    
    func setupView() {
        let button = UIButton(type: .Custom)
        button.setTitle("dismiss", forState: .Normal)
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: #selector(CrossDissolveSecondController.aniamtionAction), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func aniamtionAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
