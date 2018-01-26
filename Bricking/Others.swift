//
//  CenterTogether.swift
//  Bricking-iOS
//
//  Created by CP3 on 2018/1/8.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation

// MARK: - Center together
extension Array where Element: View {
    @discardableResult
    public func togetherCenterHorizontally() -> View {
        let wrappedView = View()
        guard self.count > 0 else { return wrappedView }
        
        var spaces = [CGFloat]()
        for itemView in self.dropFirst() {
            let space: CGFloat = itemView.leftConstraint?.constant ?? 0
            spaces.append(space)
        }
        
        self.first?.superview?.asv(wrappedView)
        self.forEach { $0.removeFromSuperview()}
        wrappedView.asv(self)
        var preView = self.first!
        
        wrappedView.centerHorizontally()
        self.alignHorizontally()
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
    func lineHorizontally(space: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) -> Array {
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
}
