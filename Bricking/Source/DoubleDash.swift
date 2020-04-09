//
//  DoubleDash.swift
//  Bricking
//
//  Created by CP3 on 2017/7/3.
//  Copyright © 2017年 CP3. All rights reserved.
//


import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

infix operator -- :AdditionPrecedence

@discardableResult
public func -- (left: SideConstraint, right: View) -> View {
    return left-right
}

@discardableResult
public func -- (left: View, right: SideConstraint) -> View {
    return left-right
}

@discardableResult
public func -- (left: [View], right: SideConstraint) -> [View] {
    return left-right
}

// MARK: - View-View
@discardableResult
public func -- (left: View, right: View) -> [View] {
    return left-right
}

@discardableResult
public func -- (left: [View], right: View) -> [View] {
    return left-right
}

// MARK: - PartialFlexibleConstraint
@discardableResult
public func -- (left: View, right: CGFloat) -> PartialFlexibleConstraint {
    return left-right
}

@discardableResult
public func -- (left: [View], right: CGFloat) -> PartialFlexibleConstraint {
    return left-right
}

@discardableResult
public func -- (left: View, right: FlexibleMargin) -> PartialFlexibleConstraint {
    return left-right
}

@discardableResult
public func -- (left: [View], right: FlexibleMargin) -> PartialFlexibleConstraint {
    return left-right
}

@discardableResult
public func -- (left: PartialFlexibleConstraint, right: View) -> [View] {
    return left-right
}

// MARK: - LeftFlexibleMargin
@discardableResult
public func -- (left: LeftFlexibleMargin, right: View) -> View {
    return left-right
}

// MARK: - RightFlexibleMargin
@discardableResult
public func -- (left: View, right: RightFlexibleMargin) -> View {
    return left-right
}

@discardableResult
public func -- (left: [View], right: RightFlexibleMargin) -> [View] {
    return left-right
}

// MARK: - Space
@discardableResult
public func -- (left: View, right: String) -> Space {
    return left-right
}

@discardableResult
public func -- (left: [View], right: String) -> Space {
    return left-right
}

@discardableResult
public func -- (left: Space, right: View) -> [View] {
    return left-right
}

// MARK: - CenterX
@discardableResult
public func -- (left: View, right: CenterX) -> [View] {
    return left-right
}

@discardableResult
public func -- (left: [View], right: CenterX) -> [View] {
    return left-right
}

@discardableResult
public func -- (left: PartialFlexibleConstraint, right: CenterX) -> [View] {
    return left-right
}
