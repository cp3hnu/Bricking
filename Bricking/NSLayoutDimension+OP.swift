//
//  NSLayoutDimension+OP.swift
//  Bricking
//
//  Created by CP3 on 2017/11/7.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public struct PriorityDimension {
    public let dimension: CPLayoutDimension
    public let priority: LayoutPriority
}

@available(iOS 9.0, *)
public struct CPLayoutDimension {
    let dimension: NSLayoutDimension
    let multiplier: CGFloat
    let constant: CGFloat
    
    static public func + (left: CPLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return CPLayoutDimension(dimension: left.dimension, multiplier: 1, constant: left.constant + right)
    }
    
    static public func - (left: CPLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return left + (-right)
    }
    
    static public func !! (left: CPLayoutDimension, right: LayoutPriority) -> PriorityDimension {
        return PriorityDimension(dimension: left, priority: right)
    }
}

@available(iOS 9.0, *)
extension NSLayoutDimension {
    static public func !! (left: NSLayoutDimension, right: LayoutPriority) -> PriorityDimension {
        
        return PriorityDimension(dimension: CPLayoutDimension(dimension: left, multiplier: 1.0, constant: 0.0), priority: right)
    }
}

// MARK: - +-*/
@available(iOS 9.0, *)
extension NSLayoutDimension {
    static public func + (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return CPLayoutDimension(dimension: left, multiplier: 1, constant: right)
    }
    
    static public func - (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return left + (-right)
    }
    
    static public func * (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return CPLayoutDimension(dimension: left, multiplier: right, constant: 0)
    }
    
    static public func / (left: NSLayoutDimension, right: CGFloat) -> CPLayoutDimension {
        return left * (1/right)
    }
    
    static public func % (left: CGFloat, right: NSLayoutDimension) -> CPLayoutDimension {
        return right * (left/100.0)
    }
}

// MARK: - Constant
@available(iOS 9.0, *)
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

// MARK: - CPLayoutDimension
@available(iOS 9.0, *)
extension NSLayoutDimension {
    @discardableResult
    static public func == (left: NSLayoutDimension, right: CPLayoutDimension) -> NSLayoutConstraint {
        let constraint = left.constraint(equalTo: right.dimension, multiplier: right.multiplier, constant: right.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func >= (left: NSLayoutDimension, right: CPLayoutDimension) -> NSLayoutConstraint {
        let constraint = left.constraint(greaterThanOrEqualTo: right.dimension, multiplier: right.multiplier, constant: right.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func <= (left: NSLayoutDimension, right: CPLayoutDimension) -> NSLayoutConstraint {
        let constraint = left.constraint(lessThanOrEqualTo: right.dimension, multiplier: right.multiplier, constant: right.constant)
        constraint.isActive = true
        return constraint
    }
}

// MARK: - NSLayoutDimension
@available(iOS 9.0, *)
extension NSLayoutDimension {
    @discardableResult
    static public func == (left: NSLayoutDimension, right: NSLayoutDimension) -> NSLayoutConstraint {
        return left == CPLayoutDimension(dimension: right, multiplier: 1.0, constant: 0.0)
    }
    
    @discardableResult
    static public func >= (left: NSLayoutDimension, right: NSLayoutDimension) -> NSLayoutConstraint {
        return left >= CPLayoutDimension(dimension: right, multiplier: 1.0, constant: 0.0)
    }
    
    @discardableResult
    static public func <= (left: NSLayoutDimension, right: NSLayoutDimension) -> NSLayoutConstraint {
        return left <= CPLayoutDimension(dimension: right, multiplier: 1.0, constant: 0.0)
    }
}

// MARK: - PriorityConstant
@available(iOS 9.0, *)
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

// MARK: - PriorityDimension
@available(iOS 9.0, *)
extension NSLayoutDimension {
    @discardableResult
    static public func == (left: NSLayoutDimension, right: PriorityDimension) -> NSLayoutConstraint {
        let constraint = left.constraint(equalTo: right.dimension.dimension, multiplier: right.dimension.multiplier, constant: right.dimension.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func >= (left: NSLayoutDimension, right: PriorityDimension) -> NSLayoutConstraint {
        let constraint = left.constraint(greaterThanOrEqualTo: right.dimension.dimension, multiplier: right.dimension.multiplier, constant: right.dimension.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func <= (left: NSLayoutDimension, right: PriorityDimension) -> NSLayoutConstraint {
        let constraint = left.constraint(lessThanOrEqualTo: right.dimension.dimension, multiplier: right.dimension.multiplier, constant: right.dimension.constant)
        constraint.priority = right.priority
        constraint.isActive = true
        return constraint
    }
}
