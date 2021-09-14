//
//  Linear.swift
//  Bricking
//
//  Created by cp3hnu on 2021/7/30.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

// MARK: - Line horizontally
extension Array where Element: View {
    @discardableResult
    // |-left-view1-space-view2-right-|
    public func linearFixedSpace(space: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) -> Array {
        guard count > 1 else { return self }
        
        var preView = first!
        preView.leading(left)
        last!.trailing(right)
        dropFirst().forEach {
            preView-space-$0
            preView = $0
        }
        
        return self
    }
    
    @discardableResult
    // |-left-view1-0-spaceView-0-view2-0-spaceView-0-view3-right-|
    public func linearEqualSpace(left: CGFloat = 0, right: CGFloat = 0) -> [View] {
        guard count > 1 else { return self }
        
        let spaceViews = (0..<count-1).map { _ in return View() }
        first!.superview?.asv(spaceViews)
        first!.leading(left)
        last!.trailing(right)
        for (idx, spaceView) in spaceViews.enumerated() {
            let item = self[idx]
            let nextItem = self[idx+1]
            item-0-spaceView-0-nextItem
        }
        spaceViews.first?.height(0).top(0)
        spaceViews.equalSizes().alignTops()
        
        return self + spaceViews
    }
    
    @discardableResult
    // |-left-spaceView-0-view1-0-spaceView-0-view2-0-spaceView-right-|
    public func linearEvenly(left: CGFloat = 0, right: CGFloat = 0) -> [View] {
        guard count > 1 else { return self }
        
        let spaceViews = (0..<count+1).map { _ in return View() }
        first!.superview?.asv(spaceViews)
        spaceViews.first!.leading(left)
        spaceViews.last!.trailing(right)
        for (idx, item) in self.enumerated() {
            let spaceItem = spaceViews[idx]
            let nextSpaceItem = spaceViews[idx+1]
            spaceItem-0-item-0-nextSpaceItem
        }
        spaceViews.first?.height(0).top(0)
        spaceViews.equalSizes().alignTops()
        
        return self + spaceViews
    }
}
