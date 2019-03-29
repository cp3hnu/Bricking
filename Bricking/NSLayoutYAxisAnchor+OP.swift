//
//  NSLayoutYAxisAnchor+OP.swift
//  Bricking-iOS
//
//  Created by CP3 on 2018/6/14.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public typealias CPLayoutYAxisAnchor = CPLayoutAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>

@available(iOS 9.0, *)
public typealias PriorityYAxisAnchor = PriorityAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>

// MARK: - NSLayoutYAxisAnchor => PriorityYAxisAnchor
@available(iOS 9.0, *)
extension NSLayoutYAxisAnchor {
    static public func !! (left: NSLayoutYAxisAnchor, right: LayoutPriority) -> PriorityYAxisAnchor {
        return PriorityYAxisAnchor(anchor: CPLayoutYAxisAnchor(anchor: left), priority: right)
    }
}

// MARK: - NSLayoutYAxisAnchor => CPLayoutYAxisAnchor
@available(iOS 9.0, *)
public extension NSLayoutYAxisAnchor {
    static func + (left: NSLayoutYAxisAnchor, right: CGFloat) -> CPLayoutYAxisAnchor {
        return CPLayoutYAxisAnchor(anchor: left, constant: right)
    }
    
    static func -  (left: NSLayoutYAxisAnchor, right: CGFloat) -> CPLayoutYAxisAnchor {
        return left + (-right)
    }
}

// MARK: - NSLayoutYAxisAnchor ~ NSLayoutYAxisAnchor
@available(iOS 9.0, *)
public extension NSLayoutYAxisAnchor {
    @discardableResult
    static func == (left: NSLayoutYAxisAnchor, right: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return left == CPLayoutYAxisAnchor(anchor: right)
    }
    
    @discardableResult
    static func >= (left: NSLayoutYAxisAnchor, right: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return left >= CPLayoutYAxisAnchor(anchor: right)
    }
    
    @discardableResult
    static func <= (left: NSLayoutYAxisAnchor, right: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return left <= CPLayoutYAxisAnchor(anchor: right)
    }
}
