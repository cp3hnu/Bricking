//
//  Center.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

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

public func centerHorizontally(_ views: View...) {
    centerHorizontally(views)
}

public func centerHorizontally(_ views: [View]) {
    views.first?.centerHorizontally()
    alignVertically(views)
}

public func centerVertically(_ views: View...) {
    centerVertically(views)
}

public func centerVertically(_ views: [View]) {
    views.first?.centerVertically()
    alignHorizontally(views)
}
