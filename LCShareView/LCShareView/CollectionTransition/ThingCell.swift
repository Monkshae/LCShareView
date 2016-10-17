//
//  ThingCell.swift
//  LCShareView
//
//  Created by licong on 16/9/21.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit
import SnapKit

class ThingCell: UICollectionViewCell {
    
    var titleLabel: UILabel?
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        imageView = UIImageView()
        contentView.addSubview(imageView!)
        imageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(150)
            make.height.equalTo(150)
        })
        
        titleLabel = UILabel()
        titleLabel?.text = "哈哈"
        titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(imageView!.snp.bottom).offset(15)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
