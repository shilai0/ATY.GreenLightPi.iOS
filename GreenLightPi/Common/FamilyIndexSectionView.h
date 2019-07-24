//
//  FamilyIndexSectionView.h
//  FamilyDemo
//
//  Created by luckyCoderCai on 2018/6/23.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FamilyBabyVaccineApiModel;

///section header
@interface FamilyIndexSectionView : UIView

@property (nonatomic, assign) BOOL display;//0: 不显示 1: 显示
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) FamilyBabyVaccineApiModel *babyVaccineApiModel;
@property (copy, nonatomic) void(^moreBtnBlock)(void);

@end
