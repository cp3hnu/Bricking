//
//  Shrink.swift
//  Bricking
//
//  Created by CP3 on 17/4/12.
//  Copyright © 2017年 CP3. All rights reserved.
//

extension View {
    private struct AssociatedKeys {
        static var previousConstraint = "previousConstraint"
        static var nextConstraint = "nextConstraint"
        static var currentConstraint = "currentConstraint"
        static var isBottomSpaceReserved = "isBottomSpaceReserved"
        static var isRightSpaceReserved = "isRightSpaceReserved"
    }
    
    private var previousConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.previousConstraint) as? NSLayoutConstraint
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.previousConstraint, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var nextConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.nextConstraint) as? NSLayoutConstraint
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.nextConstraint, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var currentConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.currentConstraint) as? NSLayoutConstraint
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.currentConstraint, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var isBottomSpaceReserved: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isBottomSpaceReserved) as? Bool
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isBottomSpaceReserved, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public var isRightSpaceReserved: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isRightSpaceReserved) as? Bool
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isRightSpaceReserved, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public var shrinkVertically: Bool {
        get {
            return isHidden
        }
        set {
            isHidden = newValue
            if newValue {
                changeVerticalConstraint()
            } else {
                self.currentConstraint?.isActive = false
                self.previousConstraint?.isActive = true
                self.nextConstraint?.isActive = true
            }
        }
    }
    
    public var shrinkHorizontally: Bool {
        get {
            return isHidden
        }
        set {
            isHidden = newValue
            if newValue {
                changeHorizontalConstraint()
            } else {
                self.currentConstraint?.isActive = false
                self.previousConstraint?.isActive = true
                self.nextConstraint?.isActive = true
            }
        }
    }
    
    private func changeVerticalConstraint() {
        let (pView, pConstraint, pAttribute, pConstant) = constraintFor(.top)
        let (nView, nConstraint, nAttribute, nConstant) = constraintFor(.bottom)
        
        guard let preView = pView, let nextView = nView, let preConstraint = pConstraint, let nextConstraint = nConstraint, let preAttribute = pAttribute, let nextAttribute = nAttribute else { return }
        
        preConstraint.isActive = false
        nextConstraint.isActive = false
        self.previousConstraint = preConstraint
        self.nextConstraint = nextConstraint
        
        var constant = pConstant
        if let isBottom = self.isBottomSpaceReserved, isBottom == true {
            constant = nConstant
        }
        
        self.currentConstraint = NSLayoutConstraint(item: preView,
                                                    attribute: preAttribute,
                                                    relatedBy: .equal,
                                                    toItem: nextView,
                                                    attribute: nextAttribute,
                                                    multiplier: 1.0,
                                                    constant: constant)
        self.currentConstraint!.isActive = true
    }
    
    private func changeHorizontalConstraint() {
        let (pView, pConstraint, pAttribute, pConstant) = constraintFor(.left)
        let (nView, nConstraint, nAttribute, nConstant) = constraintFor(.right)
        
        guard let preView = pView, let nextView = nView, let preConstraint = pConstraint, let nextConstraint = nConstraint, let preAttribute = pAttribute, let nextAttribute = nAttribute else { return }
        
        preConstraint.isActive = false
        nextConstraint.isActive = false
        self.previousConstraint = preConstraint
        self.nextConstraint = nextConstraint
        
        var constant = pConstant
        if let isRight = self.isRightSpaceReserved, isRight == true {
            constant = nConstant
        }
        
        self.currentConstraint = NSLayoutConstraint(item: preView,
                                                    attribute: preAttribute,
                                                    relatedBy: .equal,
                                                    toItem: nextView,
                                                    attribute: nextAttribute,
                                                    multiplier: 1.0,
                                                    constant: constant)
        self.currentConstraint!.isActive = true
    }
    
    private func constraintFor(_ attribute: NSLayoutAttribute) -> (View?, NSLayoutConstraint?, NSLayoutAttribute?, constant: CGFloat) {
        if let spv = superview {
            for c in spv.constraints {
                if let fi = c.firstItem as? View, fi == self && c.firstAttribute == attribute {
                    var constant = c.constant
                    if attribute == NSLayoutAttribute.left || attribute == NSLayoutAttribute.top {
                        constant = -c.constant
                    }
                    return (c.secondItem as? View, c, c.secondAttribute, constant)
                }
                
                if let si = c.secondItem as? View, si == self && c.secondAttribute == attribute {
                    var constant = c.constant
                    if attribute == NSLayoutAttribute.right || attribute == NSLayoutAttribute.bottom {
                        constant = -c.constant
                    }
                    return (c.firstItem as? View, c, c.firstAttribute, constant)
                }
            }
        }
        return (nil, nil, nil, 0)
    }
}
