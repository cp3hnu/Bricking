//
//  Vertically.swift
//  Bricking
//
//  Created by CP3 on 2017/7/2.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

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
                guard index == count - 1 else { break }
                guard let preView = topView(of: objects, at: index - 1) else { break }
                preView.bottom(m)
            case let fm as FlexibleMargin:
                previousFlexibleMargin = fm
                guard index == count - 1 else { break }
                guard let preView = topView(of: objects, at: index - 1) else { break }
                preView.bottom(fm)
            case let view as View:
                addConstraints(objects: objects, index: index, view: view, flexibleMargin: &previousFlexibleMargin)
            case let views as [View]:
                alignHorizontally(views)
                guard let view = views.first else { break }
                addConstraints(objects: objects, index: index, view: view, flexibleMargin: &previousFlexibleMargin)
            case is CenterYPlaceHolder:
                let fm: FlexibleMargin
                let idx: Int
                if let pfm = previousFlexibleMargin {
                    fm = pfm
                    idx = index - 2
                } else {
                    fm = FlexibleMargin(constant: 0, relation: .equal)
                    idx = index - 1
                }
                
                if let preView = topView(of: objects, at: idx) {
                    self.flexiableAttribute(self.laCenterY, fm: fm, attribute2: preView.laBottom)
                }
                previousFlexibleMargin = nil
            default: break
            }
        }
        
        bottomAnchorConstraints(objects: objects, flexibleMargin: previousFlexibleMargin)
        return objects.map {$0 as? View }.compactMap {$0}
    }
}

private extension View {
    func convertToCGFloat(_ number: Any) -> CGFloat {
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
    
    func topView(of objects: [Any], at index: Int) -> View? {
        guard index >= 0 else { return nil }
        
        if let view = objects[index] as? View {
            return view
        } else if let views = objects[index] as? [View] {
            return views.first
        }
        
        return nil
    }
    
    func addConstraints(objects: [Any], index: Int, view: View, flexibleMargin: inout FlexibleMargin?) {
        if let pfm = flexibleMargin, index == 1 {
            view.top(pfm)
            flexibleMargin = nil
            return
        }
        
        let fm: FlexibleMargin
        let idx: Int
        if let pfm = flexibleMargin {
            fm = pfm
            idx = index - 2
        } else {
            fm = FlexibleMargin(constant: 0, relation: .equal)
            idx = index - 1
        }
        
        guard idx >= 0 else {
            return
        }
        
        let preObject = objects[idx]
        if let preView = preObject as? View {
            self.flexiableAttribute(view.laTop, fm: fm, attribute2: preView.laBottom)
        } else if let preViews = preObject as? [View], preViews.count != 0 {
            self.flexiableAttribute(view.laTop, fm: fm, attribute2: preViews.first!.laBottom)
        } else if preObject is CenterYPlaceHolder {
            self.flexiableAttribute(view.laTop, fm: fm, attribute2: self.laCenterY)
        } else if let anchor = preObject as? NSLayoutYAxisAnchor {
            self.flexiableAnchor(view.topAnchor, fm: fm, anchor2: anchor)
        }
        
        flexibleMargin = nil
    }
    
    func bottomAnchorConstraints(objects: [Any], flexibleMargin: FlexibleMargin?) {
        guard let anchor = objects.last as? NSLayoutYAxisAnchor else { return }
        
        let lastIndex = objects.count - 1
        let fm: FlexibleMargin
        let idx: Int
        if let pfm = flexibleMargin {
            fm = FlexibleMargin(constant: -pfm.constant, relation: pfm.relation)
            idx = lastIndex - 2
        } else {
            fm = FlexibleMargin(constant: 0, relation: .equal)
            idx = lastIndex - 1
        }
        
        guard idx >= 0 else { return }
        
        let preObject = objects[idx]
        if let preView = preObject as? View {
            self.flexiableAnchor(preView.bottomAnchor, fm: fm, anchor2: anchor)
        } else if let preViews = preObject as? [View], preViews.count != 0 {
            self.flexiableAnchor(preViews.first!.bottomAnchor, fm: fm, anchor2: anchor)
        }
    }
    
    func flexiableAttribute(_ attribute1: CPLayoutAttribute,
                            fm: FlexibleMargin,
                            attribute2: CPLayoutAttribute) {
        switch fm.relation {
        case .greaterThanOrEqual:
            attribute1 >= attribute2 + fm.constant
        case .lessThanOrEqual:
            attribute1 <= attribute2 + fm.constant
        case .equal:
            attribute1 == attribute2 + fm.constant
        @unknown default:
            break
        }
    }
    
    func flexiableAnchor(_ anchor1: NSLayoutYAxisAnchor,
                         fm: FlexibleMargin,
                         anchor2: NSLayoutYAxisAnchor) {
        switch fm.relation {
        case .greaterThanOrEqual:
            anchor1 >= anchor2 + fm.constant
        case .lessThanOrEqual:
            anchor1 <= anchor2 + fm.constant
        case .equal:
            anchor1 == anchor2 + fm.constant
        @unknown default:
            break
        }
    }
}
