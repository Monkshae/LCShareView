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
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        return tableView
    }()
    let titleArray = ["淡入淡出", "滑动", "自定义动画"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "自定义跳转动画"
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: .Default, reuseIdentifier: String(UITableViewCell))
        tableViewCell.textLabel?.text = titleArray[indexPath.row]
        tableViewCell.selectionStyle = .None
        return tableViewCell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0: break
        case 1: break
        case 2: break
        default:
            break
        }
//        self.presentViewController(nav, animated: true, completion: nil)
    }
}