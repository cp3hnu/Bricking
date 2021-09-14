//
//  CenterTogether.swift
//  Bricking-iOS
//
//  Created by CP3 on 2018/1/8.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

// MARK: - Multiple views are centered horizontally together
extension Array where Element: View {
    @discardableResult
    public func groupCenterHorizontally() -> View {
        guard self.count > 1 else { return View() }
        
        let wrappedView = View()
        var spaces = [CGFloat]()
        for itemView in self.dropFirst() {
            let space: CGFloat = itemView.leadingConstraint?.constant ?? 0
            spaces.append(space)
        }
        
        self.first?.superview?.asv(wrappedView)
        wrappedView.centerHorizontally()
        
        self.forEach { $0.removeFromSuperview()}
        wrappedView.asv(self)
        self.alignHorizontally()
        
        var preView = self.first!
        self.first?.leading(0).fillVertically()
        self.last?.trailing(0)
        for (idx, space) in spaces.enumerated() {
            preView-space-self[idx + 1]
            preView = self[idx + 1]
        }
        
        return wrappedView
    }
}
