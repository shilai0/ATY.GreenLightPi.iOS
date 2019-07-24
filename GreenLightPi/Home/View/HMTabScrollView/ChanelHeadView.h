//
//  ChanelHeadView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/9/6.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChanelHeadView : UICollectionReusableView
@property (nonatomic, strong) UILabel *biaotiLab;
@property (nonatomic, strong) UILabel *tishiLab;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong)void(^editBtnBlock)(void);
@end
