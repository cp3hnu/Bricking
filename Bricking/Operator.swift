//
//  Operator.swift
//  Bricking
//
//  Created by CP3 on 2017/6/30.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

prefix operator |
@discardableResult
public prefix func | (p: View) -> View {
    return p.left(0)
}

postfix operator |
@discardableResult
public postfix func | (p: View) -> View {
    return p.right(0)
}

// MARK: - ~
infix operator ~ : HeightPrecedence
precedencegroup HeightPrecedence {
    lowerThan: AdditionPrecedence
}

@discardableResult
public func ~ (left: View, right: CGFloat) -> View {
    return left.height(right)
}

@discardableResult
public func ~ (left: View, right: FlexibleMargin) -> View {
    return left.height(right)
}

@discardableResult
public func ~ (left: [View], right: CGFloat) -> [View] {
    left.forEach{ $0.height(right) }
    return left
}

@discardableResult
public func ~ (left: [View], right: FlexibleMargin) -> [View] {
    left.forEach{ $0.height(right) }
    return left
}

// MARK: - SideConstraint
prefix operator |-
@discardableResult
public prefix func |- (p: CGFloat) -> SideConstraint {
    return SideConstraint(constant: p)
}

@discardableResult
public prefix func |- (v: View) -> View {
    v.left(8)
    return v
}

postfix operator -|
@discardableResult
public postfix func -| (p: CGFloat) -> SideConstraint {
    return SideConstraint(constant: p)
}

@discardableResult
public postfix func -| (v: View) -> View {
    v.right(8)
    return v
}

@discardableResult
public func - (left: SideConstraint, right: View) -> View {
    right.laLeft == left.constant
    return right
}

@discardableResult
public func - (left: View, right: SideConstraint) -> View {
    left.laRight == right.constant
    return left
}

@discardableResult
public func - (left: [View], right: SideConstraint) -> [View] {
    guard let last = left.last else { return left }
    last - right
    return left
}

// MARK: - view-view
@discardableResult
public func - (left: View, right: View) -> [View] {
    right.laLeft == left.laRight + 8
    return [left, right]
}

@discardableResult
public func - (left: [View], right: View) -> [View] {
    guard let last = left.last else { return left + [right] }
    last - right
    
    return left + [right]
}

// MARK: - PartialFlexibleConstraint
prefix operator >=
@discardableResult
public prefix func >= (p: CGFloat) -> FlexibleMargin {
    return FlexibleMargin(constant: p, relation: .greaterThanOrEqual)
}

prefix operator <=
@discardableResult
public prefix func <= (p: CGFloat) -> FlexibleMargin {
    return FlexibleMargin(constant: p, relation: .lessThanOrEqual)
}

@discardableResult
public func - (left: View, right: CGFloat) -> PartialFlexibleConstraint {
    let fm = FlexibleMargin(constant: right, relation: .equal)
    return PartialFlexibleConstraint(fm: fm, views: [left])
}

@discardableResult
public func - (left: [View], right: CGFloat) -> PartialFlexibleConstraint {
    let fm = FlexibleMargin(constant: right, relation: .equal)
    return PartialFlexibleConstraint(fm: fm, views: left)
}

@discardableResult
public func - (left: View, right: FlexibleMargin) -> PartialFlexibleConstraint {
    return PartialFlexibleConstraint(fm: right, views: [left])
}

@discardableResult
public func - (left: [View], right: FlexibleMargin) -> PartialFlexibleConstraint {
    return PartialFlexibleConstraint(fm: right, views: left)
}

@discardableResult
public func - (left: PartialFlexibleConstraint, right: View) -> [View] {
    guard let last = left.views.last else {
        return left.views + [right]
    }
    
    switch left.fm.relation {
    case .greaterThanOrEqual:
        right.laLeft >= last.laRight + left.fm.constant
    case .lessThanOrEqual:
        right.laLeft <= last.laRight + left.fm.constant
    case .equal:
        right.laLeft == last.laRight + left.fm.constant
    }
    return left.views + [right]
}

// MARK: - LeftFlexibleMargin
@discardableResult
public prefix func |- (fm: FlexibleMargin) -> LeftFlexibleMargin {
    return LeftFlexibleMargin(fm: fm)
}

@discardableResult
public func - (left: LeftFlexibleMargin, right: View) -> View {
    switch left.fm.relation {
    case .greaterThanOrEqual:
        right.laLeft >= left.fm.constant
    case .lessThanOrEqual:
        right.laLeft <= left.fm.constant
    case .equal:
        right.laLeft == left.fm.constant
    }
    return right
}

// MARK: - RightFlexibleMargin
@discardableResult
public postfix func -| (fm: FlexibleMargin) -> RightFlexibleMargin {
    return RightFlexibleMargin(fm: fm)
}

@discardableResult
public func - (left: View, right: RightFlexibleMargin) -> View {
    switch right.fm.relation {
    case .greaterThanOrEqual:
        left.laRight <= right.fm.constant
    case .lessThanOrEqual:
        left.laRight >= right.fm.constant
    case .equal:
        left.laRight == right.fm.constant
    }
    
    return left
}

@discardableResult
public func - (left: [View], right: RightFlexibleMargin) -> [View] {
    guard let last = left.last else { return left }
    last - right
    return left
}

// MARK: - Space
@discardableResult
public func - (left: View, right: String) -> Space {
    return Space(previousViews: [left])
}

@discardableResult
public func - (left: [View], right: String) -> Space {
    return Space(previousViews: left)
}

@discardableResult
public func - (left: Space, right: View) -> [View] {
    return left.previousViews + [right]
}

// MARK: - CenterX
@discardableResult
public func - (left: View, right: CenterXPlaceHolder) -> [View] {
    let centerXView = View()
    left.superview?.asv(centerXView)
    centerXView.centerHorizontally()
    return left - centerXView
}

@discardableResult
public func - (left: [View], right: CenterXPlaceHolder) -> [View] {
    guard let last = left.last else { return left }
    
    let centerXView = View()
    last.superview?.asv(centerXView)
    centerXView.centerHorizontally()
    return left - centerXView
}

@discardableResult
public func - (left: PartialFlexibleConstraint, right: CenterXPlaceHolder) -> [View] {
    guard let last = left.views.last else { return left.views }
    
    let centerXView = View()
    last.superview?.asv(centerXView)
    centerXView.centerHorizontally()
    return left - centerXView
}
