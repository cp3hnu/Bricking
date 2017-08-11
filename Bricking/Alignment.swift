//
//  Alignment.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

// MARK: - Center
public func alignHorizontally(_ views: View...) {
    alignHorizontally(views)
}

public func alignHorizontally(_ views: [View]) {
    align(.centerY, views: views)
}

public func alignVertically(_ views: View...) {
    alignVertically(views)
}

public func alignVertically(_ views: [View]) {
    align(.centerX, views: views)
}

// MARK: - Margin
public func alignLefts(_ views: View...) {
    alignLefts(views)
}

public func alignLefts(_ views: [View]) {
    align(.left, views: views)
}

public func alignRights(_ views: View...) {
    alignRights(views)
}

public func alignRights(_ views: [View]) {
    align(.right, views: views)
}

public func alignTops(_ views: View...) {
    alignTops(views)
}

public func alignTops(_ views: [View]) {
    align(.top, views: views)
}

public func alignBottoms(_ views: View...) {
    alignBottoms(views)
}

public func alignBottoms(_ views: [View]) {
    align(.bottom, views: views)
}

public func alignLeftAndRight(_ views: View...) {
    alignLeftAndRight(views)
}

public func alignLeftAndRight(_ views: [View]) {
    alignLefts(views)
    alignRights(views)
}

public func alignTopAndBottom(_ views: View...) {
    alignTopAndBottom(views)
}

public func alignTopAndBottom(_ views: [View]) {
    alignTops(views)
    alignBottoms(views)
}

public func alignAllEdges(_ views: View...) {
    alignAllEdges(views)
}

public func alignAllEdges(_ views: [View]) {
    alignLeftAndRight(views)
    alignTopAndBottom(views)
}

private func align(_ attribute: NSLayoutAttribute, views: [View]) {
    guard views.count > 1 else { return }
    var preView = views[0]
    for v in views[1..<views.endIndex] {
        align(attribute, v1: preView, with: v)
        preView = v
    }
}

private func align(_ attribute: NSLayoutAttribute, v1: View, with v2: View) {
    switch attribute {
    case .left:
        v1.laLeft == v2.laLeft
    case .right:
        v1.laRight == v2.laRight
    case .top:
        v1.laTop == v2.laTop
    case .bottom:
        v1.laBottom == v2.laBottom
    case .centerX:
        v1.laCenterX == v2.laCenterX
    case .centerY:
        v1.laCenterY == v2.laCenterY
    default:
        break
    }
}