//
//  ViewController.swift
//  LCShareView
//
//  Created by Maybe on 16/9/16.
//  Copyright © 2016年 Maybe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let cellTitleArray = ["淡入淡出", "滑动", "自定义Presentation"]
    let cellSubtitleArray = ["淡入淡出的动画", "交互式切换","自定义弹出框"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "自定义动画"
        view.addSubview(tableView)
        
    }
    
}


extension ViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}


