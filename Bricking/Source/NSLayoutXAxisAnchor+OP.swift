//
//  NSLayoutXAxisAnchor+OP.swift
//  Bricking-iOS
//
//  Created by CP3 on 2018/6/14.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

public typealias CPLayoutXAxisAnchor = CPLayoutAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>

public typealias PriorityXAxisAnchor = PriorityAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>

// MARK: - NSLayoutXAxisAnchor => PriorityXAxisAnchor
extension NSLayoutXAxisAnchor {
    static public func !! (left: NSLayoutXAxisAnchor, right: LayoutPriority) -> PriorityXAxisAnchor {
        return PriorityXAxisAnchor(anchor: CPLayoutXAxisAnchor(anchor: left), priority: right)
    }
}

// MARK: - NSLayoutXAxisAnchor => CPLayoutXAxisAnchor
public extension NSLayoutXAxisAnchor {
    static func + (left: NSLayoutXAxisAnchor, right: CGFloat) -> CPLayoutXAxisAnchor {
        return CPLayoutXAxisAnchor(anchor: left, constant: right)
    }
    
    static func + (left: CGFloat, right: NSLayoutXAxisAnchor) -> CPLayoutXAxisAnchor {
        return right + left
    }
    
    static func - (left: NSLayoutXAxisAnchor, right: CGFloat) -> CPLayoutXAxisAnchor {
        return left + (-right)
    }
}

// MARK: - NSLayoutXAxisAnchor ~ NSLayoutXAxisAnchor
public extension NSLayoutXAxisAnchor {
    @discardableResult
    static func == (left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return left == CPLayoutXAxisAnchor(anchor: right)
    }
    
    @discardableResult
    static func >= (left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return left >= CPLayoutXAxisAnchor(anchor: right)
    }
    
    @discardableResult
    static func <= (left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return left <= CPLayoutXAxisAnchor(anchor: right)
    }
}

