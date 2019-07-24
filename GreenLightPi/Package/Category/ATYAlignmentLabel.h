//
//  ATYAlignmentLabel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VerticalAlignmentType) {
    VerticalAlignmentTypeTop = 0,         // 居上对齐
    VerticalAlignmentTypeMiddle = 1,      // 居中对齐
    VerticalAlignmentTypeBottom = 2       // 居下对齐
};

@interface ATYAlignmentLabel : UILabel

@property (nonatomic, assign) VerticalAlignmentType textVerticalAlignment;

@end
