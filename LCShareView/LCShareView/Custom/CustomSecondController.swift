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
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 60)
        view.addSubview(label)
        label.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(144)
        }
        
        view.addSubview(slider)
        slider.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(30)
        }
        slider.addTarget(self, action: #selector(CustomSecondController.sliderValueChange(_:)), for: .valueChanged)
        
        /// 创建button
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: UIControlState())
        button.setTitle("Dismiss", for: UIControlState())
        button.addTarget(self, action: #selector(CustomSecondController.buttonDidClicked), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(-20)
            make.top.equalTo(slider.snp.bottom).offset(8)
            make.centerX.equalTo(view)
            make.width.equalTo(245)
        }
    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.updatePreferredContentSizeWithTraitCollection(newCollection)
    }
    
    func updatePreferredContentSizeWithTraitCollection(_ traitCollection: UITraitCollection) {
        //这句主要是设置 presentedView的大小，缺少这一句，无法显示presentView
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == .compact ? 270 : 420)
        slider.maximumValue = Float(self.preferredContentSize.height)
        slider.minimumValue = 220
        slider.value = self.slider.maximumValue
    }
    
    func buttonDidClicked() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func sliderValueChange(_ sender: UISlider) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: CGFloat(sender.value))
    }
}
