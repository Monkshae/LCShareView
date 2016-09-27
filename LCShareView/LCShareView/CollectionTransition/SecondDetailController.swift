//
//  SecondDetailController.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class SecondDetailController: UIViewController {

    var imageView: UIImageView = {
        let  imageView = UIImageView(frame: CGRectMake(60, 60, 200, 200))
        return imageView
    }()
    
    var overviewLabel:UILabel = {
        let label = UILabel(frame: CGRectMake(60, 60, 200, 30))
        label.font = UIFont(name: "Helvetica", size: 60)
        return label
    }()
    var thing: Thing? {
        didSet{
            imageView.image = thing?.image
        }
    }

    lazy var navTransitionRecognizer: UIScreenEdgePanGestureRecognizer = {
       let gestureRecognizer =  UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(InteractivitySecondController.animationAction(_:)))
        gestureRecognizer.edges = .Left
        return gestureRecognizer
    }()
    private var  navDelegate = NavIntertivityTransitionDelegate(gestureRecognizer: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x3A/255, green: 0xDB/255, blue: 0xD2/255, alpha: 1)
        view.addSubview(imageView)
        view.addSubview(overviewLabel)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SecondDetailController.didButtonClicked(_:)))
        view.addGestureRecognizer(navTransitionRecognizer)
    }

    
    //navigationController是共有的，离开页面后记得置空
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //将自己设置为naviagation controller 的代理，以便于做转场动画
        navigationController?.delegate = navDelegate
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //离开页面后将delegate置空
        if navigationController?.delegate != nil {
            navigationController?.delegate = nil
        }
    }
    
    
    
    func didButtonClicked(sender: UIButton)  {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func animationAction(gestureRecongizer: UIScreenEdgePanGestureRecognizer) {
        
        if let nav =  navigationController?.delegate as?  NavIntertivityTransitionDelegate {
            nav.gestureRecognizer = gestureRecongizer
        } else {
            navDelegate.gestureRecognizer = nil
        }
    
        //这句话开始后执行转场动画
        navigationController?.popViewControllerAnimated(true)
    }
    
    deinit{
        print("哈哈哈")
    }
}
