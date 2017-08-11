//
//  Bricking-iOS.h
//  Bricking-iOS
//
//  Created by CP3 on 2017/8/11.
//  Copyright © 2017年 CP3. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE || TARGET_OS_TV
    #import <UIKit/UIKit.h>
#else
    #import <AppKit/AppKit.h>
#endif

//! Project version number for Bricking.
FOUNDATION_EXPORT double BrickingVersionNumber;

//! Project version string for Bricking.
FOUNDATION_EXPORT const unsigned char BrickingVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Bricking_iOS/PublicHeader.h>

