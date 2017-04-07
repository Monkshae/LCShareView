//
//  ViewController.swift
//  LCShareView
//
//  Created by licong on 16/9/18.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    let titleArray = ["淡入淡出", "滑动", "自定义动画","CollectionViewCell渐变","PUSH"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "自定义跳转动画"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: String(describing: UITableViewCell()))
        tableViewCell.textLabel?.text = titleArray[(indexPath as NSIndexPath).row]
        return tableViewCell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav: UINavigationController
        switch (indexPath as NSIndexPath).row {
        case 0: nav = UINavigationController(rootViewController: CrossDissolveFirstController())
        case 1: nav = UINavigationController(rootViewController: InteractivityFirstController())
        case 2: nav = UINavigationController(rootViewController: CustomFirstController())
        case 3: nav = UINavigationController(rootViewController: FirstCollectionController())
        case 4: nav = UINavigationController(rootViewController: PushController())
        default:
            nav = UINavigationController()
            break
        }
        self.present(nav, animated: true, completion: nil)
    }
    

}
