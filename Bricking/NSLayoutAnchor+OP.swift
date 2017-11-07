//
//  NSLayoutAnchor+OP.swift
//  Bricking
//
//  Created by CP3 on 2017/6/30.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public struct PriorityAnchor<AnchorType> where AnchorType : AnyObject {
    let anchor: CPLayoutAnchor<AnchorType>
    let priority: LayoutPriority
}

@available(iOS 9.0, *)
public struct CPLayoutAnchor<AnchorType> where AnchorType : AnyObject {
    let anchor: NSLayoutAnchor<AnchorType>
    let constant: CGFloat
    
    static public func !! (left: CPLayoutAnchor<AnchorType>, right: LayoutPriority) -> PriorityAnchor<AnchorType> {
        return PriorityAnchor(anchor: left, priority: right)
    }
}

// MARK: - +-
@available(iOS 9.0, *)
public func + <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: CGFloat) -> CPLayoutAnchor<AnchorType> {
    return CPLayoutAnchor(anchor: left, constant: right)
}

@available(iOS 9.0, *)
public func - <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: CGFloat) -> CPLayoutAnchor<AnchorType> {
    return left + (-right)
}

// MARK: - CPLayoutAnchor
@available(iOS 9.0, *)
@discardableResult
public func == <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: CPLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
    let constraint = left.constraint(equalTo: right.anchor, constant: right.constant)
    constraint.isActive = true
    return constraint
}

@available(iOS 9.0, *)
@discardableResult
public func >= <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: CPLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
    let constraint = left.constraint(greaterThanOrEqualTo: right.anchor, constant: right.constant)
    constraint.isActive = true
    return constraint
}

@available(iOS 9.0, *)
@discardableResult
public func <= <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: CPLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
    let constraint = left.constraint(lessThanOrEqualTo: right.anchor, constant: right.constant)
    constraint.isActive = true
    return constraint
}

// MARK: - NSLayoutAnchor
@available(iOS 9.0, *)
@discardableResult
public func == <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
    return left == CPLayoutAnchor(anchor: right, constant: 0)
}

@available(iOS 9.0, *)
@discardableResult
public func >= <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
    return left >= CPLayoutAnchor(anchor: right, constant: 0)
}

@available(iOS 9.0, *)
@discardableResult
public func <= <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
    return left <= CPLayoutAnchor(anchor: right, constant: 0)
}

// MARK: - Priority
@available(iOS 9.0, *)
@discardableResult
public func == <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: PriorityAnchor<AnchorType>) -> NSLayoutConstraint {
    let constraint = left.constraint(equalTo: right.anchor.anchor, constant: right.anchor.constant)
    constraint.priority = right.priority
    constraint.isActive = true
    return constraint
}

@available(iOS 9.0, *)
@discardableResult
public func >= <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: PriorityAnchor<AnchorType>) -> NSLayoutConstraint {
    let constraint = left.constraint(greaterThanOrEqualTo: right.anchor.anchor, constant: right.anchor.constant)
    constraint.priority = right.priority
    constraint.isActive = true
    return constraint
}

@available(iOS 9.0, *)
@discardableResult
public func <= <AnchorType> (left: NSLayoutAnchor<AnchorType>, right: PriorityAnchor<AnchorType>) -> NSLayoutConstraint {
    let constraint = left.constraint(lessThanOrEqualTo: right.anchor.anchor, constant: right.anchor.constant)
    constraint.priority = right.priority
    constraint.isActive = true
    return constraint
}


