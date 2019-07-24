//
//  UIView+Layout.m
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (void)setPf_left:(CGFloat)pf_left
{
    CGRect frame = self.frame;
    frame.origin.x = pf_left;
    self.frame = frame;
}

- (CGFloat)pf_left
{
    return self.frame.origin.x;
}

- (void)setPf_top:(CGFloat)pf_top
{
    CGRect frame = self.frame;
    frame.origin.y = pf_top;
    self.frame = frame;
}

- (CGFloat)pf_top
{
    return self.frame.origin.y;
}

- (void)setPf_width:(CGFloat)pf_width
{
    CGRect frame = self.frame;
    frame.size.width = pf_width;
    self.frame = frame;
}

- (CGFloat)pf_width
{
    return self.frame.size.width;
}

- (void)setPf_height:(CGFloat)pf_height
{
    CGRect frame = self.frame;
    frame.size.height = pf_height;
    self.frame = frame;
}

- (CGFloat)pf_height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setPf_origin:(CGPoint)pf_origin
{
    CGRect frame = self.frame;
    frame.origin = pf_origin;
    self.frame = frame;
}

- (CGPoint)pf_origin
{
    return self.frame.origin;
}

- (void)setPf_size:(CGSize)pf_size
{
    CGRect frame = self.frame;
    frame.size = pf_size;
    self.frame = frame;
}

- (CGSize)pf_size
{
    return self.frame.size;
}

@end
