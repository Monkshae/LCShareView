//
//  Then.swift
//  LCShareView
//
//  Created by licong on 16/10/10.
//  Copyright © 2016年 Sean Lee. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

public protocol Then {}

extension Then where Self: Any {
    
    public func with(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    
}

extension Then where Self: AnyObject {
    
    public func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}
