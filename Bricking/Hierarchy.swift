//
//  Hierarchy.swift
//  Bricking
//
//  Created by CP3 on 2017/6/30.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
    public typealias View = UIView
    public typealias LayoutSupport = UILayoutSupport
    public typealias LayoutPriority = UILayoutPriority
    public let LayoutPriorityRequired = UILayoutPriorityRequired
#elseif os(OSX)
    import AppKit
    public typealias View = NSView
    public typealias LayoutSupport = MacLayoutSupport
    public typealias LayoutPriority = NSLayoutPriority
    public let LayoutPriorityRequired = NSLayoutPriorityRequired
#endif

extension View {
    open func asv(_ subViews: View...) {
        asv(subViews)
    }
    
    open func asv(_ subViews: [View]) {
        subViews.forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

#if os(iOS)
    extension UITableViewCell {
        open override func asv(_ subViews: [UIView]) {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.asv(subViews)
        }
    }
    
    extension UICollectionViewCell {
        open override func asv(_ subViews: [UIView]) {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.asv(subViews)
        }
    }
#endif
