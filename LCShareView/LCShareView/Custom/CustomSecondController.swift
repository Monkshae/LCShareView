//
//  CustomSecondViewController.swift
//  LCShareView
//
//  Created by licong on 16/9/20.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class CustomSecondController: UIViewController {
    
    let slider = UISlider()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updatePreferredContentSizeWithTraitCollection(self.traitCollection)
    }

    func setupView() {
        view.backgroundColor = UIColor(red: 254/255, green: 223/255, blue: 224/255, alpha: 1)
        /// 创建label
        let label = UILabel()
        label.text = "To"
        label.textAlignment = .Center
        label.font = UIFont(name: "Helvetica", size: 60)
        view.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(144)
        }
        
        view.addSubview(slider)
        slider.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(30)
        }
        slider.addTarget(self, action: #selector(CustomSecondController.sliderValueChange(_:)), forControlEvents: .ValueChanged)
        
        /// 创建button
        let button = UIButton()
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.setTitle("Dismiss", forState: .Normal)
        button.addTarget(self, action: #selector(CustomSecondController.buttonDidClicked), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(-20)
            make.top.equalTo(slider.snp_bottom).offset(8)
            make.centerX.equalTo(view)
            make.width.equalTo(245)
        }
    }

    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        self.updatePreferredContentSizeWithTraitCollection(newCollection)
    }
    
    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        //这句主要是设置 presentedView的大小，缺少这一句，无法显示presentView
        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == .Compact ? 270 : 420)
        slider.maximumValue = Float(self.preferredContentSize.height)
        slider.minimumValue = 220
        slider.value = self.slider.maximumValue
    }
    
    func buttonDidClicked() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sliderValueChange(sender: UISlider) {
        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, CGFloat(sender.value))
    }
}
