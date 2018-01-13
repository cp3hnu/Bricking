//
//  Vertically.swift
//  Bricking
//
//  Created by CP3 on 2017/7/2.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
//FIXME: UILayoutSupport Crash

extension View {
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
        
        for (index, obj) in objects.enumerated() {
            switch obj {
            case is Int: fallthrough
            case is Double: fallthrough
            case is CGFloat:
                let m = convertToCGFloat(obj)
                previousFlexibleMargin = FlexibleMargin(constant: m, relation: .equal)
                if index == count - 1 && index >= 1 {
                    if let previousView = objects[index-1] as? View {
                        previousView.bottom(m)
                    } else if let va = objects[index-1] as? [View] {
                        va.first!.bottom(m)
                    }
                }
            case let fm as FlexibleMargin:
                previousFlexibleMargin = fm
                if index == count - 1 && index >= 1 {
                    if let previousView = objects[index-1] as? View {
                        previousView.bottom(fm)
                    } else if let va = objects[index-1] as? [View] {
                        va.first!.bottom(fm)
                    }
                }
            case let view as View:
                addConstraints(objects: objects, index: index, view: view, flexibleMargin: &previousFlexibleMargin)
            case let views as [View]:
                alignHorizontally(views)
                let view = views.first!
                addConstraints(objects: objects, index: index, view: view, flexibleMargin: &previousFlexibleMargin)
            case is CenterYPlaceHolder:
                if let pfm = previousFlexibleMargin, index >= 2 {
                    if let preView = objects[index-2] as? View {
                        self.flexiableAttribute(self.laCenterY, fm: pfm, attribute2: preView.laBottom)
                    } else if let preViews = objects[index-2] as? [View] {
                        self.flexiableAttribute(self.laCenterY, fm: pfm, attribute2: preViews.first!.laBottom)
                    }
                    previousFlexibleMargin = nil
                } else {
                    guard index >= 1 else { break }
                    let fm = FlexibleMargin(constant: 0, relation: .equal)
                    if let preView = objects[index-1] as? View {
                        self.flexiableAttribute(self.laCenterY, fm: fm, attribute2: preView.laBottom)
                    } else if let preViews = objects[index-1] as? [View] {
                        self.flexiableAttribute(self.laCenterY, fm: fm, attribute2: preViews.first!.laBottom)
                    }
                }
            default: break
            }
        }
        
        if #available(iOS 9.0, *) {
            bottomAnchorConstraints(objects: objects, flexibleMargin: previousFlexibleMargin)
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
    private func flexiableAnchor(_ anchor1: NSLayoutYAxisAnchor,
                                    fm: FlexibleMargin,
                                    anchor2: NSLayoutYAxisAnchor) {
        switch fm.relation {
        case .greaterThanOrEqual:
            anchor1 >= anchor2 + fm.constant
        case .lessThanOrEqual:
            anchor1 <= anchor2 + fm.constant
        case .equal:
            anchor1 == anchor2 + fm.constant
        }
    }
    
    func addConstraints(objects: [Any], index: Int, view: View, flexibleMargin: inout FlexibleMargin?) {
        if let pfm = flexibleMargin {
            if index == 1 {
                view.top(pfm)
            } else {
                let preObject = objects[index-2]
                if let preView = preObject as? View {
                    self.flexiableAttribute(view.laTop, fm: pfm, attribute2: preView.laBottom)
                } else if let preViews = preObject as? [View] {
                    self.flexiableAttribute(view.laTop, fm: pfm, attribute2: preViews.first!.laBottom)
                } else if preObject is CenterYPlaceHolder {
                    self.flexiableAttribute(view.laTop, fm: pfm, attribute2: self.laCenterY)
                } else if let top = preObject as? LayoutSupport {
                    if #available(iOS 9.0, *) {
                        self.flexiableAnchor(view.topAnchor, fm: pfm, anchor2: top.bottomAnchor)
                    }
                }
            }
            flexibleMargin = nil
        } else {
            guard index >= 1 else {
                view.top(0)
                return
            }
            
            let fm = FlexibleMargin(constant: 0, relation: .equal)
            let preObject = objects[index-1]
            if let preView = preObject as? View {
                self.flexiableAttribute(view.laTop, fm: fm, attribute2: preView.laBottom)
            } else if let preViews = preObject as? [View] {
                self.flexiableAttribute(view.laTop, fm: fm, attribute2: preViews.first!.laBottom)
            } else if preObject is CenterYPlaceHolder {
                self.flexiableAttribute(view.laTop, fm: fm, attribute2: self.laCenterY)
            } else if let top = preObject as? LayoutSupport {
                if #available(iOS 9.0, *) {
                    self.flexiableAnchor(view.topAnchor, fm: fm, anchor2: top.bottomAnchor)
                }
            }
        }
    }
    
    @available(iOS 9.0, *)
    func bottomAnchorConstraints(objects: [Any], flexibleMargin: FlexibleMargin?) {
        guard let bottom = objects.last as? LayoutSupport else { return }
        
        let lastIndex = objects.count - 1
        if let pfm = flexibleMargin {
            let fm = FlexibleMargin(constant: -pfm.constant, relation: pfm.relation)
            guard lastIndex >= 2 else { return }
            let preObject = objects[lastIndex-2]
            if let preView = preObject as? View {
                self.flexiableAnchor(preView.bottomAnchor, fm: fm, anchor2: bottom.topAnchor)
            } else if let preViews = preObject as? [View] {
                self.flexiableAnchor(preViews.first!.bottomAnchor, fm: fm, anchor2: bottom.topAnchor)
            }
        } else {
            guard lastIndex >= 1 else { return }
            let fm = FlexibleMargin(constant: 0, relation: .equal)
            let preObject = objects[lastIndex-1]
            if let preView = preObject as? View {
                self.flexiableAnchor(preView.bottomAnchor, fm: fm, anchor2: bottom.topAnchor)
            } else if let preViews = preObject as? [View] {
                self.flexiableAnchor(preViews.first!.bottomAnchor, fm: fm, anchor2: bottom.topAnchor)
            }
        }
    }
}
