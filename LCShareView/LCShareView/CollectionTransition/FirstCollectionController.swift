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
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ThingCell.classForCoder(), forCellWithReuseIdentifier: String(describing: ThingCell.self))
        return collectionView
    }()
    
    lazy var things = Thing.exampleThings()
    //这里必须写成成员变量，不然会被释放掉
    fileprivate var  navDelegate = NavIntertivityTransitionDelegate(gestureRecognizer: nil)
    
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
        navigationItem.title = "CollectionViewCell渐变"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(InteractivityFirstController.animationAction(_:)))
    }
    
    func animationAction(_ sender: AnyObject) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    //根据thing object获取cell
    func collectionViewCellForThing(_ thing: Thing) -> ThingCell? {
        if let index = things.index(of: thing) {
            return collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? ThingCell
        }else {
            return nil
        }
    }
    
}

extension FirstCollectionController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return things.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ThingCell.self), for: indexPath) as! ThingCell
        cell.imageView?.image = things[(indexPath as NSIndexPath).row].image
        cell.titleLabel?.text = things[(indexPath as NSIndexPath).row].title
        return cell
    }
    
}


extension FirstCollectionController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = SecondDetailController()
        controller.thing = things[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension FirstCollectionController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is FirstCollectionController && toVC is SecondDetailController {
            return  NavigationPushAnimator()
        }else {
            return nil
        }
    }
}
