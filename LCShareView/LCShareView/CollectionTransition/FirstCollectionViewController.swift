//
//  firstCollectionViewController.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class FirstCollectionViewController: UIViewController {

    
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
    }
    func animationAction(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)    
    }

}

extension FirstCollectionViewController:  UICollectionViewDataSource {
    
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


extension FirstCollectionViewController: UICollectionViewDelegate {
    
    
}


extension FirstCollectionViewController: UICollectionViewDelegateFlowLayout {
   
}