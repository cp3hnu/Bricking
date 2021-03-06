//
//  Structure.swift
//  Bricking
//
//  Created by CP3 on 2017/6/30.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

public struct SideConstraint {
    public let constant: CGFloat
}

public struct FlexibleMargin {
    public let constant: CGFloat
    public let relation: LayoutRelation
}

public struct PartialFlexibleConstraint {
    public let fm: FlexibleMargin
    public let views: [View]
}

public struct LeftFlexibleMargin {
    public let fm: FlexibleMargin
}

public struct RightFlexibleMargin {
    let fm: FlexibleMargin
}

public struct Space {
    public let previousViews: [View]
}

public struct Percentage {
    public let value: CGFloat
}

postfix operator %
public postfix func % (v: CGFloat) -> Percentage {
    return Percentage(value: v)
}

public enum LayoutConstraintAxis: Int {
    case horizontal = 0
    case vertical = 1
}

// center placeholder
public struct CenterX {}
public struct CenterY {}

public let centerX = CenterX()
public let centerY = CenterY()

public struct PriorityAttribute {
    public let attribute: CPLayoutAttribute
    public let priority: LayoutPriority
}

public struct PriorityConstant {
    public let constant: CGFloat
    public let priority: LayoutPriority
}

infix operator !! : PriorityPrecedence
precedencegroup PriorityPrecedence {
    lowerThan: AdditionPrecedence
    higherThan: ComparisonPrecedence
}

public func !! (left: CGFloat, right: LayoutPriority) -> PriorityConstant {
    return PriorityConstant(constant: left, priority: right)
}

public func !! (left: Int, right: LayoutPriority) -> PriorityConstant {
    return PriorityConstant(constant: CGFloat(left), priority: right)
}

public func !! (left: Float, right: LayoutPriority) -> PriorityConstant {
    return PriorityConstant(constant: CGFloat(left), priority: right)
}

public func !! (left: Double, right: LayoutPriority) -> PriorityConstant {
    return PriorityConstant(constant: CGFloat(left), priority: right)
}

public func !! (left: CPLayoutAttribute, right: LayoutPriority) -> PriorityAttribute {
    return PriorityAttribute(attribute: left, priority: right)
}



