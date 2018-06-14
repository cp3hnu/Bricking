//
//  NSLayoutXAxisAnchor+OP.swift
//  Bricking-iOS
//
//  Created by CP3 on 2018/6/14.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public typealias CPLayoutXAxisAnchor = CPLayoutAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>

@available(iOS 9.0, *)
public typealias PriorityXAxisAnchor = PriorityAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>

// MARK: - NSLayoutXAxisAnchor => PriorityXAxisAnchor
@available(iOS 9.0, *)
extension NSLayoutXAxisAnchor {
    static public func !! (left: NSLayoutXAxisAnchor, right: LayoutPriority) -> PriorityXAxisAnchor {
        return PriorityXAxisAnchor(anchor: CPLayoutXAxisAnchor(anchor: left), priority: right)
    }
}

// MARK: - PriorityXAxisAnchor => CPLayoutXAxisAnchor
@available(iOS 9.0, *)
public extension NSLayoutXAxisAnchor {
    static public func + (left: NSLayoutXAxisAnchor, right: CGFloat) -> CPLayoutXAxisAnchor {
        return CPLayoutXAxisAnchor(anchor: left, constant: right)
    }
    
    static public func - (left: NSLayoutXAxisAnchor, right: CGFloat) -> CPLayoutXAxisAnchor {
        return left + (-right)
    }
}

// MARK: - PriorityXAxisAnchor ~ PriorityXAxisAnchor
@available(iOS 9.0, *)
public extension NSLayoutXAxisAnchor {
    @discardableResult
    static public func == (left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return left == CPLayoutXAxisAnchor(anchor: right)
    }
    
    @discardableResult
    static public func >= (left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return left >= CPLayoutXAxisAnchor(anchor: right)
    }
    
    @discardableResult
    static public func <= (left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return left <= CPLayoutXAxisAnchor(anchor: right)
    }
}

