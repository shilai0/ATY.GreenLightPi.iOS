//
//  FCMainListView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

@class FamilyIndexSectionView;
@interface FCMainListView : BaseTableView
@property (nonatomic, strong) FamilyIndexSectionView *headzeroview;
@property (nonatomic, strong) FamilyIndexSectionView *headoneview;
@property (nonatomic, strong) FamilyIndexSectionView *headtwoview;
@property (nonatomic, strong) FamilyIndexSectionView *headthreeview;
@property (nonatomic, copy) void(^switchBlock)(void);
@end
