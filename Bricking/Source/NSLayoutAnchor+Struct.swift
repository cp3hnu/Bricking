//
//  NSLayoutAnchor+Struct.swift
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

public struct CPLayoutAnchor<Anchor, AnchorType> where Anchor : NSLayoutAnchor<AnchorType> {
    let anchor: Anchor
    let multiplier: CGFloat
    let constant: CGFloat
    
    init(anchor: Anchor, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
    }
    
    static public func + (left: CPLayoutAnchor<Anchor, AnchorType>, right: CGFloat) -> CPLayoutAnchor<Anchor, AnchorType> {
        return CPLayoutAnchor(anchor: left.anchor, constant: left.constant + right)
    }
    
    static public func - (left: CPLayoutAnchor<Anchor, AnchorType>, right: CGFloat) -> CPLayoutAnchor<Anchor, AnchorType> {
        return left + (-right)
    }
    
    // MARK: - CPLayoutAnchor => PriorityAnchor
    static public func !! (left: CPLayoutAnchor<Anchor, AnchorType>, right: LayoutPriority) -> PriorityAnchor<Anchor, AnchorType> {
        return PriorityAnchor(anchor: left, priority: right)
    }
    
    // MARK: - NSLayoutAnchor ~ CPLayoutAnchor
    @discardableResult
    static public func == (left: NSLayoutAnchor<AnchorType>, right: CPLayoutAnchor<Anchor, AnchorType>) -> NSLayoutConstraint {
        let constraint = left.constraint(equalTo: right.anchor, constant: right.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func >= (left: NSLayoutAnchor<AnchorType>, right: CPLayoutAnchor<Anchor, AnchorType>) -> NSLayoutConstraint {
        let constraint = left.constraint(greaterThanOrEqualTo: right.anchor, constant: right.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func <= (left: NSLayoutAnchor<AnchorType>, right: CPLayoutAnchor<Anchor, AnchorType>) -> NSLayoutConstraint {
        let constraint = left.constraint(lessThanOrEqualTo: right.anchor, constant: right.constant)
        constraint.isActive = true
        return constraint
    }
}

public struct PriorityAnchor<Anchor, AnchorType> where Anchor : NSLayoutAnchor<AnchorType> {
    let anchor: CPLayoutAnchor<Anchor, AnchorType>
    let priority: LayoutPriority
    
    // MARK: - NSLayoutAnchor ~ PriorityAnchor
    @discardableResult
    static public func == (left: NSLayoutAnchor<AnchorType>, right: PriorityAnchor<Anchor, AnchorType>) -> NSLayoutConstraint {
        let constraint = left.constraint(equalTo: right.anchor.anchor, constant: right.anchor.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func >= (left: NSLayoutAnchor<AnchorType>, right: PriorityAnchor<Anchor, AnchorType>) -> NSLayoutConstraint {
        let constraint = left.constraint(greaterThanOrEqualTo: right.anchor.anchor, constant: right.anchor.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func <= (left: NSLayoutAnchor<AnchorType>, right: PriorityAnchor<Anchor, AnchorType>) -> NSLayoutConstraint {
        let constraint = left.constraint(lessThanOrEqualTo: right.anchor.anchor, constant: right.anchor.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
}

