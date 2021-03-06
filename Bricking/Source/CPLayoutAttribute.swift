//
//  CPLayoutAttribute.swift
//  Bricking
//
//  Created by CP3 on 2017/7/1.
//  Copyright © 2017年 CP3. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

public struct CPLayoutAttribute {
    let view: View
    let attribute: LayoutAttribute
    let constant: CGFloat
    let multiplier: CGFloat
    
    init(view: View, attribute: LayoutAttribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
        self.view = view
        self.attribute = attribute
        self.constant = constant
        self.multiplier = multiplier
    }
}

extension View {
    public var laWidth: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .width)
    }
    
    public var laHeight: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .height)
    }
    
    public var laTop: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .top)
    }
    
    public var laBottom: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .bottom)
    }
    
    public var laLeading: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .leading)
    }
    
    public var laTrailing: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .trailing)
    }
    
    public var laCenterX: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .centerX)
    }
    
    public var laCenterY: CPLayoutAttribute {
        return CPLayoutAttribute(view: self, attribute: .centerY)
    }
}

