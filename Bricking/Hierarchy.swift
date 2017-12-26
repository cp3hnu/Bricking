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
    public typealias LayoutRelation = NSLayoutRelation
    public typealias LayoutAttribute = NSLayoutAttribute
    public let LayoutPriorityRequired = UILayoutPriority.required
    
#elseif os(OSX)
    import AppKit
    public typealias View = NSView
    public typealias LayoutSupport = MacLayoutSupport
    public typealias LayoutPriority = NSLayoutConstraint.Priority
    public typealias LayoutRelation = NSLayoutConstraint.Relation
    public typealias LayoutAttribute = NSLayoutConstraint.Attribute
    public let LayoutPriorityRequired = NSLayoutConstraint.Priority.required
#endif

extension View {
    @discardableResult
    open func asv(_ subViews: View...) -> View {
        return asv(subViews)
    }
    
    @objc @discardableResult
    open func asv(_ subViews: [View]) -> View {
        subViews.forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
}

#if os(iOS)
    extension UITableViewCell {
        @discardableResult
        open override func asv(_ subViews: [UIView]) -> View {
            return contentView.asv(subViews)
        }
    }
    
    extension UICollectionViewCell {
        @discardableResult
        open override func asv(_ subViews: [UIView]) -> View {
            return contentView.asv(subViews)
        }
    }
#endif
