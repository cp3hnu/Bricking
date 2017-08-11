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

public enum CPLayoutConstraintAxis: Int {
    case horizontal
    case vertical
}

public struct SuperCenterX {}
public struct SuperCenterY {}

@available(iOS 9.0, *)
public class MacLayoutSupport {
    var topAnchor: NSLayoutYAxisAnchor = NSLayoutYAxisAnchor()
    var bottomAnchor: NSLayoutYAxisAnchor = NSLayoutYAxisAnchor()
    var heightAnchor: NSLayoutDimension = NSLayoutDimension()
}

