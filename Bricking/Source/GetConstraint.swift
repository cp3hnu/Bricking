//
//  GetConstraint.swift
//  Bricking
//
//  Created by CP3 on 2017/7/2.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

// MARK: - Single Constraint
extension View {
    public var leadingConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .leading)
    }
    
    public var trailingConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .trailing)
    }
    
    public var topConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .top)
    }
    
    public var bottomConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .bottom)
    }
    
    public var widthConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .width)
    }
    
    public var heightConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .height)
    }
    
    public var centerXConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .centerX)
    }
    
    public var centerYConstraint: NSLayoutConstraint? {
        return constraintFor(attribute: .centerY)
    }
    
    private func constraintFor(attribute: LayoutAttribute) -> NSLayoutConstraint? {
        if attribute == .width || attribute == .height {
            return constraintFor(attribute: attribute, targets: [self, superview].compactMap({return $0}))
        } else {
            return constraintFor(attribute: attribute, targets: [superview, self].compactMap({return $0}))
        }
    }
    
    private func constraintFor(attribute: LayoutAttribute, targets: [View]) -> NSLayoutConstraint? {
        for target in targets {
            for c in target.constraints {
                if let fi = c.firstItem as? View, fi == self && c.firstAttribute == attribute {
                    return c
                }
                if let si = c.secondItem as? View, si == self && c.secondAttribute == attribute {
                    return c
                }
            }
        }
        
        return nil
    }
}

// MARK: - multiple Constraints
extension View {
    public func constraintsFor(attribute: LayoutAttribute) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        for target in [superview, self].compactMap({return $0}) {
            for c in target.constraints {
                if let fi = c.firstItem as? View, fi == self && c.firstAttribute == attribute {
                    constraints.append(c)
                }
                if let si = c.secondItem as? View, si == self && c.secondAttribute == attribute {
                    constraints.append(c)
                }
            }
        }
        
        return constraints
    }
}

