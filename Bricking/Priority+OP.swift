//
//  Priority+Ext.swift
//  Bricking
//
//  Created by CP3 on 2017/12/22.
//  Copyright © 2017年 CP3. All rights reserved.
//

public extension LayoutPriority {
    public static func + (left: LayoutPriority, right: Float) -> LayoutPriority {
        return LayoutPriority(rawValue: left.rawValue + right)
    }
    
    public static func - (left: LayoutPriority, right: Float) -> LayoutPriority {
        return LayoutPriority(rawValue: left.rawValue - right)
    }
}



