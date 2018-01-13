//
//  Alignment.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

// MARK: - Center
@discardableResult
public func alignHorizontally(_ views: View...) -> [View] {
    return alignHorizontally(views)
}

@discardableResult
public func alignHorizontally(_ views: [View]) -> [View] {
    align(.centerY, views: views)
    return views
}

@discardableResult
public func alignVertically(_ views: View...) -> [View] {
    return alignVertically(views)
}

@discardableResult
public func alignVertically(_ views: [View]) -> [View] {
    align(.centerX, views: views)
    return views
}

// MARK: - Margin
@discardableResult
public func alignLefts(_ views: View...) -> [View] {
    return alignLefts(views)
}

@discardableResult
public func alignLefts(_ views: [View]) -> [View] {
    align(.left, views: views)
    return views
}

@discardableResult
public func alignRights(_ views: View...) -> [View] {
    return alignRights(views)
}

@discardableResult
public func alignRights(_ views: [View]) -> [View] {
    align(.right, views: views)
    return views
}

@discardableResult
public func alignTops(_ views: View...) -> [View] {
    return alignTops(views)
}

@discardableResult
public func alignTops(_ views: [View]) -> [View] {
    align(.top, views: views)
    return views
}

@discardableResult
public func alignBottoms(_ views: View...) -> [View] {
    return alignBottoms(views)
}

@discardableResult
public func alignBottoms(_ views: [View]) -> [View] {
    align(.bottom, views: views)
    return views
}

@discardableResult
public func alignLeftAndRights(_ views: View...) -> [View] {
    return alignLeftAndRights(views)
}

@discardableResult
public func alignLeftAndRights(_ views: [View]) -> [View] {
    alignLefts(views)
    alignRights(views)
    return views
}

@discardableResult
public func alignTopAndBottoms(_ views: View...) -> [View] {
    return alignTopAndBottoms(views)
}

@discardableResult
public func alignTopAndBottoms(_ views: [View]) -> [View] {
    alignTops(views)
    alignBottoms(views)
    return views
}

@discardableResult
public func alignAllEdges(_ views: View...) -> [View] {
    return alignAllEdges(views)
}

@discardableResult
public func alignAllEdges(_ views: [View]) -> [View] {
    alignLeftAndRights(views)
    alignTopAndBottoms(views)
    return views
}

private func align(_ attribute: LayoutAttribute, views: [View]) {
    guard views.count > 1 else { return }
    var preView = views[0]
    for v in views[1..<views.endIndex] {
        align(attribute, v1: preView, with: v)
        preView = v
    }
}

private func align(_ attribute: LayoutAttribute, v1: View, with v2: View) {
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

extension Array where Element == View {
    @discardableResult
    public func alignLefts() -> Array {
        return Bricking.alignLefts(self)
    }
    
    @discardableResult
    public func alignRights() -> Array {
        return Bricking.alignRights(self)
    }
    
    @discardableResult
    public func alignTops() -> Array {
        return Bricking.alignTops(self)
    }
    
    @discardableResult
    public func alignBottoms() -> Array {
        return Bricking.alignBottoms(self)
    }
    
    @discardableResult
    public func alignHorizontally() -> Array {
        return Bricking.alignHorizontally(self)
    }
    
    @discardableResult
    public func alignVertically() -> Array {
        return Bricking.alignVertically(self)
    }
}
