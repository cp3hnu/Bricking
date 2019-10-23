//
//  Center.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

extension View {
    @discardableResult
    public func centerInContainer() -> Self {
        centerHorizontally()
        centerVertically()
        return self
    }
    
    @discardableResult
    public func centerHorizontally(_ offset: CGFloat = 0) -> Self {
        self.laCenterX == offset
        return self
    }
    
    @discardableResult
    public func centerVertically(_ offset: CGFloat = 0) -> Self {
        self.laCenterY == offset
        return self
    }
}

@discardableResult
public func centerHorizontally(_ views: View...) -> [View] {
    return centerHorizontally(views)
}

@discardableResult
public func centerHorizontally(_ views: [View]) -> [View]  {
    views.first?.centerHorizontally()
    alignVertically(views)
    return views
}

@discardableResult
public func centerVertically(_ views: View...) -> [View]  {
    return centerVertically(views)
}

@discardableResult
public func centerVertically(_ views: [View]) -> [View]  {
    views.first?.centerVertically()
    alignHorizontally(views)
    return views
}

extension Array where Element: View {
    @discardableResult
    public func centerHorizontally() -> Array<View> {
        return Bricking.centerHorizontally(self)
    }
    
    @discardableResult
    public func centerVertically() -> Array<View> {
        return Bricking.centerVertically(self)
    }
}
