//
//  Grid.swift
//  Bricking-iOS
//
//  Created by CP3 on 2018/1/8.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: UIView {
    public func grid(numberOfLine: Int, edgeInsets: UIEdgeInsets = UIEdgeInsets.zero, hSpace: CGFloat = 0, vSpace: CGFloat = 0) {
        
        guard count > 0 else { return }
        guard let superView = self.first!.superview else {
            return
        }
        
        self.equalWidths()
        if count < numberOfLine {
            self.first!.width((100.0/CGFloat(count))%)
        }
        
        self.first!.top(edgeInsets.top).left(edgeInsets.left)
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






