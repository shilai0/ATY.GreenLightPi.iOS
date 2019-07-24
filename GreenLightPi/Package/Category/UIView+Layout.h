//
//  UIView+Layout.h
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

/** 快捷方式 frame.origin.x */
@property(nonatomic, assign) CGFloat pf_left;
/** 快捷方式 frame.origin.y */
@property(nonatomic, assign) CGFloat pf_top;
/** 快捷方式 frame.size.width */
@property(nonatomic, assign) CGFloat pf_width;
/** 快捷方式 frame.size.height */
@property(nonatomic, assign) CGFloat pf_height;
/** 快捷方式 center.x */
@property(nonatomic, assign) CGFloat centerX;
/** 快捷方式 center.y */
@property(nonatomic, assign) CGFloat centerY;
/** 快捷方式 frame.origin */
@property(nonatomic, assign) CGPoint pf_origin;
/** 快捷方式 frame.size */
@property(nonatomic, assign) CGSize pf_size;

//@property (nonatomic) CGFloat tz_left;        ///< Shortcut for frame.origin.x.
//@property (nonatomic) CGFloat tz_top;         ///< Shortcut for frame.origin.y
//@property (nonatomic) CGFloat tz_right;       ///< Shortcut for frame.origin.x + frame.size.width
//@property (nonatomic) CGFloat tz_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
//@property (nonatomic) CGFloat tz_width;       ///< Shortcut for frame.size.width.
//@property (nonatomic) CGFloat tz_height;      ///< Shortcut for frame.size.height.
//@property (nonatomic) CGFloat tz_centerX;     ///< Shortcut for center.x
//@property (nonatomic) CGFloat tz_centerY;     ///< Shortcut for center.y
//@property (nonatomic) CGPoint tz_origin;      ///< Shortcut for frame.origin.
//@property (nonatomic) CGSize  tz_size;        ///< Shortcut for frame.size.

@end
