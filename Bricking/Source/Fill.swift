//
//  Fill.swift
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
    public func fillContainer(_ padding: CGFloat = 0) -> Self {
        fillHorizontally(padding)
        fillVertically(padding)
        return self
    }
    
    public func fillContainer(insets: EdgeInsets) -> Self {
        self.laLeading == insets.left
        self.laTrailing == insets.right
        self.laTop == insets.top
        self.laBottom == insets.bottom
        return self
    }
    
    @discardableResult
    public func fillVertically(_ points: CGFloat = 0) -> Self {
        self.laTop == points
        self.laBottom == points
        return self
    }
    
    @discardableResult
    public func fillHorizontally(_ points: CGFloat = 0) -> Self {
        self.laLeading == points
        self.laTrailing == points
        return self
    }
}
