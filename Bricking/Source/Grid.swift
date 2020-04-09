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

extension Array where Element: View {
    public func grid(numberOfLine: Int, edgeInsets: EdgeInsets = EdgeInsets(top: 0, left: 0, bottom: 0, right: 0), hSpace: CGFloat = 0, vSpace: CGFloat = 0) {
        
        guard count > 0 else { return }
        guard let superView = self.first!.superview else {
            return
        }
        
        self.equalWidths()
        if count < numberOfLine {
            self.first!.width((100.0/CGFloat(numberOfLine))%)
        }
        
        self.first!.top(edgeInsets.top).leading(edgeInsets.left)
        self.last!.bottom(edgeInsets.bottom)
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
                (preHoriView-hSpace-itemView-edgeInsets.right-|).alignHorizontally()
            default:
                (preHoriView-hSpace-itemView).alignHorizontally()
                preHoriView = itemView
            }
        }
    }
}






