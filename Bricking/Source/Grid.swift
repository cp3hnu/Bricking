//
//  Grid.swift
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

// MARK: - Grid Layout
extension Array where Element: View {
    /// Grid layout.
    /// - Parameters:
    ///   - numberOfLine: The number of line.
    ///   - edgeInsets: The edge insets.
    ///   - hSpace: The horizotal space between views.
    ///   - vSpace: The vertical space between lines.
    ///   - equalWidth: Whether views is equal width. The default value is true.
    ///   - stretch: Whether stretch view  when the count of views less than numberOfLine. The default value is true.
    public func grid(numberOfLine: Int, edgeInsets: EdgeInsets = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0), hSpace: CGFloat = 0, vSpace: CGFloat = 0, equalWidth: Bool = true, stretch: Bool = true) {
        
        guard count > 0 else { return }
        guard let superView = self.first!.superview else {
            return
        }
        
        // 是否等宽
        if equalWidth {
            self.equalWidths()
        }
       
        self.first!.top(edgeInsets.top).leading(edgeInsets.left)
        self.last!.bottom(edgeInsets.bottom)

        // 如果只有一个且一排只排一个
        if stretch && numberOfLine == 1 && count == 1 {
            self.last!.trailing(edgeInsets.right)
            return
        }
        
        if count < numberOfLine {
            self.first!.laWidth == (CGFloat(1) / CGFloat(numberOfLine)) * superView.laWidth - (edgeInsets.left + edgeInsets.right + CGFloat(numberOfLine - 1) * hSpace) / CGFloat(numberOfLine)
        }
        
        var preHoriView = self.first!
        var preVertView = self.first!
        for (idx, itemView) in self.enumerated() {
            switch idx % numberOfLine {
            case 0:
                if idx != 0 {
                    superView.layout(
                        preVertView,
                        vSpace,
                        |-edgeInsets.left-itemView
                    )
                    preHoriView = itemView
                    preVertView = itemView
                }
            case numberOfLine - 1:
                (preHoriView-hSpace-itemView).alignHorizontally()
                // 是否伸展到右边界
                if stretch {
                    itemView-edgeInsets.right-|
                }
            default:
                (preHoriView-hSpace-itemView).alignHorizontally()
                preHoriView = itemView
            }
        }
    }
}






