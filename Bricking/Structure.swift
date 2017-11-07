//
//  Structure.swift
//  Bricking
//
//  Created by CP3 on 2017/6/30.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

public struct SideConstraint {
    public let constant: CGFloat
}

public struct FlexibleMargin {
    public let constant: CGFloat
    public let relation: NSLayoutRelation
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

public struct CenterXPlaceHolder {}
public struct CenterYPlaceHolder {}
public let centerX = CenterXPlaceHolder()
public let centerY = CenterYPlaceHolder()

@available(iOS 9.0, *)
public class MacLayoutSupport {
    var topAnchor: NSLayoutYAxisAnchor = NSLayoutYAxisAnchor()
    var bottomAnchor: NSLayoutYAxisAnchor = NSLayoutYAxisAnchor()
    var heightAnchor: NSLayoutDimension = NSLayoutDimension()
}

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



