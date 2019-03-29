//
//  NSLayoutDimension+OP.swift
//  Bricking
//
//  Created by CP3 on 2017/11/7.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

public typealias CPLayoutDimension = CPLayoutAnchor<NSLayoutDimension, NSLayoutDimension>

public typealias PriorityDimension = PriorityAnchor<NSLayoutDimension, NSLayoutDimension>

// MARK: - NSLayoutDimension => PriorityDimension
extension NSLayoutDimension {
    static public func !! (left: NSLayoutDimension, right: LayoutPriority) -> PriorityDimension {
        return PriorityDimension(anchor: CPLayoutDimension(anchor: left), priority: right)
    }
}

// MARK: - NSLayoutDimension => CPLayoutDimension
extension NSLayoutDimension {
    static public func + (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return CPLayoutDimension(anchor: left, multiplier: 1, constant: right)
    }
    
    static public func - (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return left + (-right)
    }
    
    static public func * (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return CPLayoutDimension(anchor: left, multiplier: right, constant: 0)
    }
    
    static public func / (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return left * (1/right)
    }
    
    static public func % (left: CGFloat, right: NSLayoutDimension) -> CPLayoutDimension {
        return right * (left/100.0)
    }
}

// MARK: - NSLayoutDimension ~ Constant
extension NSLayoutDimension {
    @discardableResult
    static public func == (left: NSLayoutDimension, right: CGFloat) -> NSLayoutConstraint {
        let constraint = left.constraint(equalToConstant: right)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func >= (left: NSLayoutDimension, right: CGFloat) -> NSLayoutConstraint {
        let constraint = left.constraint(greaterThanOrEqualToConstant: right)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func <= (left: NSLayoutDimension, right: CGFloat) -> NSLayoutConstraint {
        let constraint = left.constraint(lessThanOrEqualToConstant: right)
        constraint.isActive = true
        return constraint
    }
}

// MARK: - NSLayoutDimension ~ NSLayoutDimension
extension NSLayoutDimension {
    @discardableResult
    static public func == (left: NSLayoutDimension, right: NSLayoutDimension) -> NSLayoutConstraint {
        return left == CPLayoutDimension(anchor: right, multiplier: 1.0, constant: 0.0)
    }
    
    @discardableResult
    static public func >= (left: NSLayoutDimension, right: NSLayoutDimension) -> NSLayoutConstraint {
        return left >= CPLayoutDimension(anchor: right, multiplier: 1.0, constant: 0.0)
    }
    
    @discardableResult
    static public func <= (left: NSLayoutDimension, right: NSLayoutDimension) -> NSLayoutConstraint {
        return left <= CPLayoutDimension(anchor: right, multiplier: 1.0, constant: 0.0)
    }
}

// MARK: - NSLayoutDimension ~ PriorityConstant
extension NSLayoutDimension {
    @discardableResult
    static public func == (left: NSLayoutDimension, right: PriorityConstant) -> NSLayoutConstraint {
        let constraint = left.constraint(equalToConstant: right.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func >= (left: NSLayoutDimension, right: PriorityConstant) -> NSLayoutConstraint {
        let constraint = left.constraint(greaterThanOrEqualToConstant: right.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func <= (left: NSLayoutDimension, right: PriorityConstant) -> NSLayoutConstraint {
        let constraint = left.constraint(lessThanOrEqualToConstant: right.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
}
