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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.fillContainer()
        equalWidths(self, containerView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func asv(_ subViews: [View]) {
        containerView.asv(subViews)
    }
}
#endif
