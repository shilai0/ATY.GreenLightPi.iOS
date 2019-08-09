//
//  ReadButton+EnlargeHitArea.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/8/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "ReadButton+EnlargeHitArea.h"
#import "ReadButton.h"
#import <objc/runtime.h>
#import "VTPictureBookSDK.framework/Headers/VTAudioManager.h"

@implementation ReadButton (EnlargeHitArea)

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect relativeFrame = self.bounds;
    CGRect bounds = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    return CGRectContainsPoint(bounds, point);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [VTAudioManager sendMessage:MSG_BTN_EF];
    [super touchesBegan:touches withEvent:event];
}


@end
