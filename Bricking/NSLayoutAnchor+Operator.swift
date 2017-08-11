//
//  NSLayoutAnchor+Operator.swift
//  Bricking
//
//  Created by CP3 on 2017/6/30.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
@discardableResult
public func ==<AnchorType: AnyObject> (left: NSLayoutAnchor<AnchorType>, right: (NSLayoutAnchor<AnchorType>, CGFloat)) -> NSLayoutConstraint {
    let constraint = left.constraint(equalTo: right.0, constant: right.1)
    constraint.isActive = true
    return constraint
}

@available(iOS 9.0, *)
@discardableResult
public func >=<AnchorType: AnyObject> (left: NSLayoutAnchor<AnchorType>, right: (NSLayoutAnchor<AnchorType>, CGFloat)) -> NSLayoutConstraint {
    let constraint = left.constraint(greaterThanOrEqualTo: right.0, constant: right.1)
    constraint.isActive = true
    return constraint
}

@available(iOS 9.0, *)
@discardableResult
public func <=<AnchorType: AnyObject> (left: NSLayoutAnchor<AnchorType>, right: (NSLayoutAnchor<AnchorType>, CGFloat)) -> NSLayoutConstraint {
    let constraint = left.constraint(lessThanOrEqualTo: right.0, constant: right.1)
    constraint.isActive = true
    return constraint
}

@available(iOS 9.0, *)
public extension NSLayoutDimension {
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
    
    @discardableResult
    static public func == (left: NSLayoutDimension, right: (NSLayoutDimension, CGFloat, CGFloat)) -> NSLayoutConstraint {
        let constraint = left.constraint(equalTo: right.0, multiplier: right.1, constant: right.2)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func >= (left: NSLayoutDimension, right: (NSLayoutDimension, CGFloat, CGFloat)) -> NSLayoutConstraint {
        let constraint = left.constraint(greaterThanOrEqualTo: right.0, multiplier: right.1, constant: right.2)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    static public func <= (left: NSLayoutDimension, right: (NSLayoutDimension, CGFloat, CGFloat)) -> NSLayoutConstraint {
        let constraint = left.constraint(lessThanOrEqualTo: right.0, multiplier: right.1, constant: right.2)
        constraint.isActive = true
        return constraint
    }
}
