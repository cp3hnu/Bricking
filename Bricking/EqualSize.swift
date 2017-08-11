//
//  EqualSize.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

@discardableResult
public func equalSizes(_ views: View...) -> [View] {
    return equalSizes(views)
}

@discardableResult
public func equalSizes(_ views: [View]) -> [View] {
    equalWidths(views)
    equalHeights(views)
    return views
}


@discardableResult
public func equalWidths(_ views: View...) -> [View] {
    return equalWidths(views)
}

@discardableResult
public func equalWidths(_ views: [View]) -> [View] {
    equal(.width, views: views)
    return views
}

@discardableResult
public func equalHeights(_ views: View...) -> [View] {
    return equalHeights(views)
}

@discardableResult
public func equalHeights(_ views: [View]) -> [View] {
    equal(.height, views: views)
    return views
}

private func equal(_ attribute: NSLayoutAttribute, views: [View]) {
    guard views.count > 1 else { return }
    var preView = views[0]
    for v in views[1..<views.endIndex] {
        if attribute == .width {
            v.laWidth == preView.laWidth
        } else {
            v.laHeight == preView.laHeight
        }
        preView = v
    }
}

public extension View {
    @discardableResult
    public func heightEqualsWidth() -> Self {
        self.laWidth == self.laHeight
        return self
    }
}

