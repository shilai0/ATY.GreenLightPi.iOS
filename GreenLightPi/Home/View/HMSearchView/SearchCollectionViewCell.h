//
//  SearchCollectionViewCell.h
//  CYSearchDemo
//
//  Created by toro宇 on 2018/6/21.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *titleLab;
+(CGFloat)cellWidthForData:(NSString *)title;
@end
