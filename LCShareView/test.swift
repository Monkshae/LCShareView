//
//  test.swift
//  LCShareView
//
//  Created by licong on 16/10/10.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit

class test: NSObject {
    
    let label = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "Hello, World!"
    }
}
