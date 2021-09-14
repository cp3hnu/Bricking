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
    /// Linear layout with fixed space between views.
    ///
    /// |-leading-view1-space-view2-trailing-|
    ///
    /// - Parameters:
    ///   - space: The fiexed space.
    ///   - leading: The leading margin.
    ///   - trailing: The trailing margin.
    /// - Returns: Array of views.
    @discardableResult
    public func linearFixedSpace(space: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) -> Array {
        guard count > 1 else { return self }
        
        var preView = first!
        preView.leading(leading)
        last!.trailing(trailing)
        dropFirst().forEach {
            preView-space-$0
            preView = $0
        }
        
        return self
    }
    
    /// Linear layout with equal space between views.
    ///
    /// |-leading-view1-0-spaceView-0-view2-0-spaceView-0-view3-trailing-|
    ///
    /// - Parameters:
    ///   - leading: The leading margin.
    ///   - trailing: The trailing margin.
    /// - Returns: Array of views.
    @discardableResult
    public func linearEqualSpace(leading: CGFloat = 0, trailing: CGFloat = 0) -> [View] {
        guard count > 1 else { return self }
        
        let spaceViews = (0..<count-1).map { _ in return View() }
        first!.superview?.asv(spaceViews)
        first!.leading(leading)
        last!.trailing(trailing)
        for (idx, spaceView) in spaceViews.enumerated() {
            let item = self[idx]
            let nextItem = self[idx+1]
            item-0-spaceView-0-nextItem
        }
        spaceViews.first?.height(0).top(0)
        spaceViews.equalSizes().alignTops()
        
        return self + spaceViews
    }
    
    /// Linear layout with equal space between views and between views and margin.
    ///
    /// |-leading-spaceView-0-view1-0-spaceView-0-view2-0-spaceView-trailing-|
    ///
    /// - Parameters:
    ///   - leading: The leading margin.
    ///   - trailing: The trailing margin.
    /// - Returns: Array of views.
    @discardableResult
    public func linearEvenly(leading: CGFloat = 0, trailing: CGFloat = 0) -> [View] {
        guard count > 1 else { return self }
        
        let spaceViews = (0..<count+1).map { _ in return View() }
        first!.superview?.asv(spaceViews)
        spaceViews.first!.leading(leading)
        spaceViews.last!.trailing(trailing)
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
