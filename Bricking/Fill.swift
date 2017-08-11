//
//  Fill.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

public extension View {
    @discardableResult
    public func fillContainer(_ padding: CGFloat = 0) -> Self {
        fillHorizontally(padding)
        fillVertically(padding)
        return self
    }
    
    @discardableResult
    public func fillVertically(_ points: CGFloat = 0) -> Self {
        return fill(.vertical, points: points)
    }
    
    @discardableResult
    public func fillHorizontally(_ points: CGFloat = 0) -> Self {
        return fill(.horizontal, points: points)
    }
    
    private func fill(_ axis: LayoutConstraintAxis, points: CGFloat = 0) -> Self {
        if axis == .horizontal {
            self.laLeft == points
            self.laRight == points
        } else {
            self.laTop == points
            self.laBottom == points
        }
        return self
    }
}
