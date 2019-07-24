//
//  SearchCollectionViewCell.m
//  CYSearchDemo
//
//  Created by toro宇 on 2018/6/21.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell
+ (void)load
{
    
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = KHEXRGB(0xE7E7E7);
        self.layer.cornerRadius = 13;
        self.layer.masksToBounds = YES;
        
        UILabel *lab = [[UILabel alloc] init];
        [self addSubview:lab];
        _titleLab = lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = KHEXRGB(0x333333);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KHEXRGB(0xE7E7E7);
        self.layer.cornerRadius = 13;
        self.layer.masksToBounds = YES;
        
        UILabel *lab = [[UILabel alloc] init];
        [self addSubview:lab];
        _titleLab = lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = KHEXRGB(0x333333);
    }
    return self;
}


+(CGFloat)cellWidthForData:(NSString *)title
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(1000,1000) options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:attributes context:nil].size;
    return textSize.width + 11 * 2;
}
@end
