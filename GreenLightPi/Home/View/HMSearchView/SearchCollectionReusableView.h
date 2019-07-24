//
//  SearchCollectionReusableView.h
//  CYSearchDemo
//
//  Created by toro宇 on 2018/6/21.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic,strong)void(^deleteBtnBlock)(void);
@end
