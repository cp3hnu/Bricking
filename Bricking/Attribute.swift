//
//  Attribute.swift
//  Bricking
//
//  Created by CP3 on 2017/6/30.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation

// MARK: - Fixable
extension View {
    @discardableResult
    public func left(_ points: CGFloat) -> Self {
        self.laLeft == points
        return self
    }
    
    @discardableResult
    public func right(_ points: CGFloat) -> Self {
        self.laRight == points
        return self
    }
    
    @discardableResult
    public func top(_ points: CGFloat) -> Self {
        self.laTop == points
        return self
    }
    
    @discardableResult
    public func bottom(_ points: CGFloat) -> Self {
        self.laBottom == points
        return self
    }
    
    @discardableResult
    public func size(_ points: CGFloat) -> Self {
        width(points)
        height(points)
        return self
    }
    
    @discardableResult
    public func width(_ points: CGFloat) -> Self {
        self.laWidth == points
        return self
    }
    
    @discardableResult
    public func height(_ points: CGFloat) -> Self {
        self.laHeight == points
        return self
    }
}

// MARK: - Flexible
extension View {
    @discardableResult
    public func left(_ fm: FlexibleMargin) -> Self {
        return flexiableAttribute(self.laLeft, fm: fm)
    }
    
    @discardableResult
    public func right(_ fm: FlexibleMargin) -> Self {
        return flexiableAttribute(self.laRight, fm: fm)
    }
    
    @discardableResult
    public func top(_ fm: FlexibleMargin) -> Self {
        return flexiableAttribute(self.laTop, fm: fm)
    }
    
    @discardableResult
    public func bottom(_ fm: FlexibleMargin) -> Self {
        return flexiableAttribute(self.laBottom, fm: fm)
    }
    
    @discardableResult
    public func width(_ fm: FlexibleMargin) -> Self {
        return flexiableAttribute(self.laWidth, fm: fm)
    }
    
    @discardableResult
    public func height(_ fm: FlexibleMargin) -> Self {
        return flexiableAttribute(self.laHeight, fm: fm)
    }
    
    private func flexiableAttribute(_ attribute: CPLayoutAttribute, fm: FlexibleMargin) -> Self {
        switch fm.relation {
        case .greaterThanOrEqual:
            attribute >= fm.constant
        case .lessThanOrEqual:
            attribute <= fm.constant
        case .equal:
            attribute == fm.constant
        }
        
        return self
    }
}

// MARK: - Percentage
extension View {
    @discardableResult
    public func left(_ p: Percentage) -> Self {
        if let spv = superview {
            self.laLeft == p.value % spv.laRight
        }
        return self
    }
    
    @discardableResult
    public func right(_ p: Percentage) -> Self {
        if let spv = superview {
            if p.value >= 100 {
                self.laRight == spv.laLeft
            } else {
                self.laRight == (100 - p.value) % spv.laRight
            }
        }
        return self
    }
    
    @discardableResult
    public func top(_ p: Percentage) -> Self {
        if let spv = superview {
            self.laTop == p.value % spv.laBottom
        }
        return self
    }
    
    @discardableResult
    public func bottom(_ p: Percentage) -> Self {
        if let spv = superview {
            if p.value >= 100 {
                self.laBottom == spv.laTop
            } else {
                self.laBottom == (100 - p.value) % spv.laBottom
            }
        }
        return self
    }
    
    @discardableResult
    public func size(_ p: Percentage) -> Self {
        width(p)
        height(p)
        return self
    }
    
    @discardableResult
    public func width(_ p: Percentage) -> Self {
        if let spv = superview {
            self.laWidth == p.value % spv.laWidth
        }
        return self
    }
    
    @discardableResult
    public func height(_ p: Percentage) -> Self {
        if let spv = superview {
            self.laHeight == p.value % spv.laHeight
        }
        return self
    }
}
