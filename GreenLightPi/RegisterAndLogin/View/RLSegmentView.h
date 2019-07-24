//
//  RLSegmentView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLSegmentView : UIView
- (instancetype)initWithItems:(NSArray *)items;
@property(copy,nonatomic)void(^DidSegmentClickBlock)(NSInteger index);
@end
