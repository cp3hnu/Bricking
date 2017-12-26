//
//  CPLayoutAttribute+OP.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

// MARK: - +-*/%
public extension CPLayoutAttribute {
    static public func + (left: CPLayoutAttribute, right: CGFloat) -> CPLayoutAttribute {
        return CPLayoutAttribute(view: left.view, attribute: left.attribute, multiplier: left.multiplier, constant: left.constant + right)
    }
    
    static public func - (left: CPLayoutAttribute, right: CGFloat) -> CPLayoutAttribute {
        return left + (-right)
    }
    
    static public func * (left: CPLayoutAttribute, right: CGFloat) -> CPLayoutAttribute {
        return CPLayoutAttribute(view: left.view, attribute: left.attribute, multiplier: left.multiplier * right, constant:left.constant)
    }
    
    static public func / (left: CPLayoutAttribute, right: CGFloat) -> CPLayoutAttribute {
        return left * (1.0/right)
    }
    
    static public func % (left: CGFloat, right: CPLayoutAttribute) -> CPLayoutAttribute {
        return right * (left/100.0)
    }
}

// MARK: - Relative to super constraints
public extension CPLayoutAttribute {
    @discardableResult
    static public func == (left: CPLayoutAttribute, right: CGFloat) -> NSLayoutConstraint? {
        return relativeToSuperView(left: left, relation: .equal, right: right)
    }
    
    @discardableResult
    static public func >= (left: CPLayoutAttribute, right: CGFloat) -> NSLayoutConstraint? {
        return relativeToSuperView(left: left, relation: .greaterThanOrEqual, right: right)
    }
    
    @discardableResult
    static public func <= (left: CPLayoutAttribute, right: CGFloat) -> NSLayoutConstraint? {
        return relativeToSuperView(left: left, relation: .lessThanOrEqual, right: right)
    }
    
    @discardableResult
    static public func == (left: CPLayoutAttribute, right: PriorityConstant) -> NSLayoutConstraint? {
        return relativeToSuperView(left: left, relation: .equal, right: right.constant, priority: right.priority)
    }
    
    @discardableResult
    static public func >= (left: CPLayoutAttribute, right: PriorityConstant) -> NSLayoutConstraint? {
        return relativeToSuperView(left: left, relation: .greaterThanOrEqual, right: right.constant, priority: right.priority)
    }
    
    @discardableResult
    static public func <= (left: CPLayoutAttribute, right: PriorityConstant) -> NSLayoutConstraint? {
        return relativeToSuperView(left: left, relation: .lessThanOrEqual, right: right.constant, priority: right.priority)
    }
    
    static private func relativeToSuperView(left: CPLayoutAttribute, relation: LayoutRelation, right: CGFloat, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint? {
        let attribute = left.attribute
        var superview = left.view.superview
        if superview == nil && attribute != .width && attribute != .height  {
            return nil
        }
        
        var constant = right
        if attribute == .width || attribute == .height {
            superview = nil
        }
        
        if attribute == .right || attribute == .bottom {
            constant = -right
        }
        
        let constraint = NSLayoutConstraint(item: left.view,
                                            attribute: left.attribute,
                                            relatedBy: relation,
                                            toItem: superview,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}

// MARK: - Relative to other constraints
public extension CPLayoutAttribute {
    @discardableResult
    static public func == (left: CPLayoutAttribute, right: CPLayoutAttribute) -> NSLayoutConstraint? {
        return relativeToAttribute(left: left, relation: .equal, right: right)
    }
    
    @discardableResult
    static public func >= (left: CPLayoutAttribute, right: CPLayoutAttribute) -> NSLayoutConstraint? {
        return relativeToAttribute(left: left, relation: .greaterThanOrEqual, right: right)
    }
    
    @discardableResult
    static public func <= (left: CPLayoutAttribute, right: CPLayoutAttribute) -> NSLayoutConstraint? {
        return relativeToAttribute(left: left, relation: .lessThanOrEqual, right: right)
    }
    
    @discardableResult
    static public func == (left: CPLayoutAttribute, right: PriorityAttribute) -> NSLayoutConstraint? {
        return relativeToAttribute(left: left, relation: .equal, right: right.attribute, priority: right.priority)
    }
    
    @discardableResult
    static public func >= (left: CPLayoutAttribute, right: PriorityAttribute) -> NSLayoutConstraint? {
        return relativeToAttribute(left: left, relation: .greaterThanOrEqual, right: right.attribute, priority: right.priority)
    }
    
    @discardableResult
    static public func <= (left: CPLayoutAttribute, right: PriorityAttribute) -> NSLayoutConstraint? {
        return relativeToAttribute(left: left, relation: .lessThanOrEqual, right: right.attribute, priority: right.priority)
    }
    
    static private func relativeToAttribute(left: CPLayoutAttribute, relation: LayoutRelation, right: CPLayoutAttribute, priority: LayoutPriority = LayoutPriorityRequired) -> NSLayoutConstraint? {
        guard let _ = closestCommonAncestor(left.view, right.view) else { return nil }
        let constraint = NSLayoutConstraint(item: left.view,
                                            attribute: left.attribute,
                                            relatedBy: relation,
                                            toItem: right.view,
                                            attribute: right.attribute,
                                            multiplier: right.multiplier,
                                            constant: right.constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}

private func closestCommonAncestor(_ a: View, _ b: View) -> View? {
    let (aSuper, bSuper) = (a.superview, b.superview)
    if a === b { return a }
    if a === bSuper { return a }
    if b === aSuper { return b }
    if aSuper === bSuper { return aSuper }
    let ancestorsOfA = Set(ancestors(a))
    for ancestor in ancestors(b) {
        if ancestorsOfA.contains(ancestor) {
            return ancestor
        }
    }
    
    return .none
}

private func ancestors(_ v: View) -> AnySequence<View> {
    return AnySequence { () -> AnyIterator<View> in
        var view: View? = v
        return AnyIterator {
            let current = view
            view = view?.superview
            return current
        }
    }
}
