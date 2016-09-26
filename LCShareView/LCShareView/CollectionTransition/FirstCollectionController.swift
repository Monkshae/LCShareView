//
//  firstCollectionViewController.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class FirstCollectionController: UIViewController {

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(150, 200)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(ThingCell.classForCoder(), forCellWithReuseIdentifier: String(ThingCell))
        return collectionView
    }()
    
    lazy var things = Thing.exampleThings()
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //将自己设置为naviagation controller 的代理，以便于做转场动画
        navigationController?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //离开页面后将delegate置空
        if navigationController?.delegate != nil {
            navigationController?.delegate = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "CollectionViewCell渐变"
        view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InteractivityFirstController.animationAction(_:)))
        
//        transitioningDelegate = NavIntertivityTransitionDelegate()
    }
    func animationAction(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    //根据thing object获取cell
    func collectionViewCellForThing(thing: Thing) -> ThingCell? {
        if let index = things.indexOf(thing) {
            return collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? ThingCell
        }else {
            return nil
        }
    }
    
}

extension FirstCollectionController:  UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return things.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(ThingCell), forIndexPath: indexPath) as! ThingCell
        cell.imageView?.image = things[indexPath.row].image
        cell.titleLabel?.text = things[indexPath.row].title
        return cell
    }
    
}


extension FirstCollectionController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = SecondDetailController()
        controller.thing = things[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension FirstCollectionController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is FirstCollectionController && toVC is SecondDetailController {
            return  NavigationPushAnimator()
        }else {
            return nil
        }
    }
}