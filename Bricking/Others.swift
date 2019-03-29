//
//  CenterTogether.swift
//  Bricking-iOS
//
//  Created by CP3 on 2018/1/8.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation

// MARK: - Multiple views are centered horizontally together
extension Array where Element: View {
    @discardableResult
    public func groupCenterHorizontally() -> View {
        guard self.count > 0 else { return View() }
        
        let wrappedView = View()
        var spaces = [CGFloat]()
        for itemView in self.dropFirst() {
            let space: CGFloat = itemView.leftConstraint?.constant ?? 0
            spaces.append(space)
        }
        
        self.first?.superview?.asv(wrappedView)
        wrappedView.centerHorizontally()
        
        self.forEach { $0.removeFromSuperview()}
        wrappedView.asv(self)
        self.alignHorizontally()
        
        var preView = self.first!
        self.first?.left(0).fillVertically()
        self.last?.right(0)
        for (idx, space) in spaces.enumerated() {
            preView-space-self[idx + 1]
            preView = self[idx + 1]
        }
        
        return wrappedView
    }
}

// MARK: - Line horizontally
extension Array where Element: View {
    @discardableResult
    public func linearFixedSpace(space: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) -> Array {
        guard count > 0 else { return self }
        
        var preView = first!
        preView.left(left)
        last!.right(right)
        dropFirst().forEach {
            preView-space-$0
            preView = $0
        }
        
        return self
    }
    
    @discardableResult
    public func linearEqualSpace(left: CGFloat = 0, right: CGFloat = 0) -> [View] {
        guard count > 0 else { return self }
        
        let spaceViews = (0..<count-1).map { _ in return View() }
        
        first!.superview?.asv(spaceViews)
        first!.left(left)
        last!.right(right)
        for (idx, spaceView) in spaceViews.enumerated() {
            let item = self[idx]
            let nextItem = self[idx+1]
            item-0-spaceView-0-nextItem
        }
        spaceViews.equalWidths()
        
        return self + spaceViews
    }
}
