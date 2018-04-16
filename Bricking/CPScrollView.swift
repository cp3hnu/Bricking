//
//  CPScrollView.swift
//  Bricking
//
//  Created by CP3 on 2017/9/21.
//  Copyright © 2017年 CP3. All rights reserved.
//

#if os(iOS)
import UIKit

open class CPScrollView: UIScrollView {
    public let containerView = UIView()
    
    public var isWidthEqual: Bool = false {
        didSet {
            if isWidthEqual {
                equalWidths(self, containerView)
            } else {
                containerView.widthConstraint?.isActive = false
            }
        }
    }
    
    public var isHeightEqual: Bool = false {
        didSet {
            if isHeightEqual {
                equalHeights(self, containerView)
            } else {
                containerView.heightConstraint?.isActive = false
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.fillContainer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    override open func asv(_ subViews: [UIView]) -> UIView {
        containerView.asv(subViews)
        return self
    }
}
#endif
