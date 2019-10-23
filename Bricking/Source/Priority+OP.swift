//
//  Priority+Ext.swift
//  Bricking
//
//  Created by CP3 on 2017/12/22.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

public extension LayoutPriority {
    static func + (left: LayoutPriority, right: Float) -> LayoutPriority {
        return LayoutPriority(rawValue: left.rawValue + right)
    }
    
    static func - (left: LayoutPriority, right: Float) -> LayoutPriority {
        return LayoutPriority(rawValue: left.rawValue - right)
    }
}



