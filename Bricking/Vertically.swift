//
//  Vertically.swift
//  Bricking
//
//  Created by CP3 on 2017/7/2.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

public extension View {
    @discardableResult
    public func layout(_ objects: Any...) -> [View] {
        return layoutVertically(objects)
    }
    
    @discardableResult
    public func layoutDynamically(_ objects: [Any]) -> [View] {
        return layoutVertically(objects)
    }
    
    private func layoutVertically(_ objects: [Any]) -> [View] {
        let count = objects.count
        var previousFlexibleMargin: FlexibleMargin? = nil
        
        let addConstraintsVertically = { (index: Int, view: View) in
            if let pfm = previousFlexibleMargin {
                if index == 1 {
                    view.top(pfm)
                } else {
                    if let preView = objects[index-2] as? View {
                        self.flexiableAttribute(view.laTop, fm: pfm, attribute2: preView.laBottom)
                    } else if let preViews = objects[index-2] as? [View] {
                        self.flexiableAttribute(view.laTop, fm: pfm, attribute2: preViews.first!.laBottom)
                    } else if objects[index-2] is SuperCenterY {
                        self.flexiableAttribute(view.laTop, fm: pfm, attribute2: self.laCenterY)
                    } else if let top = objects[index-2] as? LayoutSupport {
                        if #available(iOS 9.0, *) {
                            self.flexiableAttribute(view.topAnchor, fm: pfm, anchor2: top.bottomAnchor)
                        }
                    }
                }
                previousFlexibleMargin = nil
            } else {
                if index != 0 {
                    let fm = FlexibleMargin(constant: 0, relation: .equal)
                    if let preView = objects[index-1] as? View {
                        self.flexiableAttribute(view.laTop, fm: fm, attribute2: preView.laBottom)
                    } else if let preViews = objects[index-1] as? [View] {
                        self.flexiableAttribute(view.laTop, fm: fm, attribute2: preViews.first!.laBottom)
                    } else if objects[index-1] is SuperCenterY {
                        self.flexiableAttribute(view.laTop, fm: fm, attribute2: self.laCenterY)
                    } else if let top = objects[index-1] as? LayoutSupport {
                        if #available(iOS 9.0, *) {
                            self.flexiableAttribute(view.topAnchor, fm: fm, anchor2: top.bottomAnchor)
                        }
                    }
                }
            }
        }
        
        for (index, obj) in objects.enumerated() {
            switch obj {
            case is Int: fallthrough
            case is Double: fallthrough
            case is CGFloat:
                let m = convertToCGFloat(obj)
                previousFlexibleMargin = FlexibleMargin(constant: m, relation: .equal)
                if index == count - 1 && count > 1 {
                    if let previousView = objects[index-1] as? View {
                        previousView.bottom(m)
                    } else if let va = objects[index-1] as? [View] {
                        va.first!.bottom(m)
                    }
                }
            case let fm as FlexibleMargin:
                previousFlexibleMargin = fm
                if index == count - 1 && count > 1 {
                    if let previousView = objects[index-1] as? View {
                        previousView.bottom(fm)
                    } else if let va = objects[index-1] as? [View] {
                        va.first!.bottom(fm)
                    }
                }
            case let view as View:
                addConstraintsVertically(index, view)
            case let views as [View]:
                alignHorizontally(views)
                let view = views.first!
                addConstraintsVertically(index, view)
            case is SuperCenterY:
                if let pfm = previousFlexibleMargin, index != 1 {
                    if let preView = objects[index-2] as? View {
                        self.flexiableAttribute(self.laCenterY, fm: pfm, attribute2: preView.laBottom)
                    } else if let preViews = objects[index-2] as? [View] {
                        self.flexiableAttribute(self.laCenterY, fm: pfm, attribute2: preViews.first!.laBottom)
                    }
                    previousFlexibleMargin = nil
                } else {
                    if index != 0 {
                        let fm = FlexibleMargin(constant: 0, relation: .equal)
                        if let preView = objects[index-1] as? View {
                            self.flexiableAttribute(self.laCenterY, fm: fm, attribute2: preView.laBottom)
                        } else if let preViews = objects[index-1] as? [View] {
                            self.flexiableAttribute(self.laCenterY, fm: fm, attribute2: preViews.first!.laBottom)
                        }
                    }
                }
            default: ()
            }
        }
        
        return objects.map {$0 as? View }.flatMap {$0}
    }
    
    private func convertToCGFloat(_ number: Any) -> CGFloat {
        var m: CGFloat = 0
        if let i = number as? Int {
            m = CGFloat(i)
        } else if let d = number as? Double {
            m = CGFloat(d)
        } else if let cg = number as? CGFloat {
            m = cg
        }
        return m
    }
    
    private func flexiableAttribute(_ attribute1: CPLayoutAttribute,
                                    fm: FlexibleMargin,
                                    attribute2: CPLayoutAttribute) {
        switch fm.relation {
        case .greaterThanOrEqual:
            attribute1 >= attribute2 + fm.constant
        case .lessThanOrEqual:
            attribute1 <= attribute2 + fm.constant
        case .equal:
            attribute1 == attribute2 + fm.constant
        }
    }
    
    @available(iOS 9.0, *)
    private func flexiableAttribute(_ anchor1: NSLayoutYAxisAnchor,
                                    fm: FlexibleMargin,
                                    anchor2: NSLayoutYAxisAnchor) {
        switch fm.relation {
        case .greaterThanOrEqual:
            anchor1 >= (anchor2, fm.constant)
        case .lessThanOrEqual:
            anchor1 <= (anchor2, fm.constant)
        case .equal:
            anchor1 == (anchor2, fm.constant)
        }
    }
}
