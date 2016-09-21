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
    
    var thing: Thing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x3A/255, green: 0xDB/255, blue: 0xD2/255, alpha: 1)
        view.addSubview(imageView)
        view.addSubview(overviewLabel)
    }

}


//extension SecondDetailController: UINavigationControllerDelegate {
//    
//    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if fromVC == self && toVC is FirstCollectionController {
//            return  ExpandTransition()
//        }else {
//            return nil
//        }
//    }
//}