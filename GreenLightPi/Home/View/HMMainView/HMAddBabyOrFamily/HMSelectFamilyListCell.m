//
//  HMSelectFamilyListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/2.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMSelectFamilyListCell.h"
#import "UIImageView+WebCache.h"
#import "FamilyApiModel.h"

@interface HMSelectFamilyListCell()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSMutableArray *headImageArr;
@end

@implementation HMSelectFamilyListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSelectFamilyCellViews];
    }
    return self;
}

- (void)creatSelectFamilyCellViews {
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.bottom.equalTo(@(-16));
        make.width.height.equalTo(@40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.equalTo(self.backView.mas_right).offset(13);
        make.height.equalTo(@16);
        make.right.equalTo(@(-16));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@68);
        make.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (void)setModel:(FamilyApiModel *)model {
    _model = model;
    if (_model.userId == [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue]) {
        self.nameLabel.textColor = KHEXRGB(0x00D399);
    }
    NSString *defaultStr = [NSString stringWithFormat:@"%@(%ld人)",_model.familyName,_model.familyMembers.count];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:defaultStr];
    NSString *memberStr = [NSString stringWithFormat:@"%ld",_model.familyMembers.count];
    //设置颜色
    [attributeStr addAttribute:NSForegroundColorAttributeName value:KHEXRGB(0x999999) range:NSMakeRange(attributeStr.length - (memberStr.length + 3), memberStr.length + 3)];
    self.nameLabel.attributedText = attributeStr;
    [self creatHeadImageViewMemberArr:_model.familyMembers];
}

- (void)creatHeadImageViewMemberArr:(NSArray *)memberArr {
    [self.headImageArr enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.headImageArr removeAllObjects];
    for (int i = 0; i < memberArr.count; i ++) {
        FamilyMemberApiModel *memberModel = [memberArr objectAtIndex:i];
        UIImageView *headImageView = [[UIImageView alloc] init];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:memberModel.imagePath] placeholderImage:[UIImage imageNamed:@"parentCenter"]];
        XSViewBorderRadius(headImageView, 2, 0, KHEXRGB(0xFFFFFF));
        [self.backView addSubview:headImageView];
        [self.headImageArr addObject:headImageView];
        
        NSArray *headArr = [[NSArray alloc] init];
        
        if (memberArr.count < 9) {
            headArr = memberArr;
        } else {
            headArr = [memberArr subarrayWithRange:NSMakeRange(0, 9)];
        }
        
        switch (headArr.count) {
            case 1:
            {
                [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.backView);
                }];
            }
                break;
            case 2:
            {
                [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@((i+1)+((40-3)/2)*i));
                    make.centerY.equalTo(self.backView.mas_centerY);
                    make.width.height.equalTo(@((40-3)/2));
                }];
            }
                break;
            case 3:
            {
                if (i == 0) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(@1);
                        make.centerX.equalTo(self.backView.mas_centerX);
                        make.width.height.equalTo(@((40-3)/2));
                    }];
                } else {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(i+((40-3)/2)*(i-1)));
                        make.top.equalTo(@(((40-3)/2)+2));
                        make.width.height.equalTo(@((40-3)/2));
                    }];
                }
            }
                break;
            case 4:
            {
                [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@((i%2+1)+((40-3)/2)*(i%2)));
                    make.top.equalTo(@((i/2+1)+((40-3)/2)*(i/2)));
                    make.width.height.equalTo(@((40-3)/2));
                    
                }];
            }
                break;
            case 5:
            {
                if (i > 1) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(((40-4)/3)*(i-2)+(i-2)));
                        make.bottom.equalTo(@(-8));
                        make.height.width.equalTo(@((40-4)/3));
                    }];
                } else {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(8+((40-4)/3)*i+i));
                        make.top.equalTo(@8);
                        make.height.width.equalTo(@((40-4)/3));
                    }];
                }
            }
                break;
            case 6:
            {
                [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@(((40-4)/3)*(i%3)+(i%3+1)));
                    make.top.equalTo(@(8 + ((40-4)/3)*(i/3)+(i/3)));
                    make.height.width.equalTo(@((40-4)/3));
                }];
            }
                break;
            case 7:
            {
                if (i == 0) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.backView.mas_centerX);
                        make.top.equalTo(@1);
                        make.width.height.equalTo(@((40-4)/3));
                    }];
                } else if (i > 0 && i < 4) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(((40-4)/3)*(i-1)+i));
                        make.top.equalTo(@((40-4)/3+1));
                        make.height.width.equalTo(@((40-4)/3));
                    }];
                } else if (i > 3 && i < 7) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(((40-4)/3)*(i-4)+(i-3)));
                        make.top.equalTo(@(((40-4)/3)*2+2));
                        make.height.width.equalTo(@((40-4)/3));
                    }];
                }
            }
                break;
            case 8:
            {
                if (i == 0 || i == 1) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(((40-4)/3)*i+(i+1)));
                        make.top.equalTo(@1);
                        make.width.height.equalTo(@((40-4)/3));
                    }];
                } else if (i > 1 && i < 5) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(((40-4)/3)*(i-2)+(i-1)));
                        make.top.equalTo(@((40-4)/3+1));
                        make.height.width.equalTo(@((40-4)/3));
                    }];
                } else if (i > 4 && i < 8) {
                    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(@(((40-4)/3)*(i-5)+(i-4)));
                        make.top.equalTo(@(((40-4)/3)*2+2));
                        make.height.width.equalTo(@((40-4)/3));
                    }];
                }
            }
                break;
            case 9:
            {
                [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@((i%3+1)+((40-3)/3)*(i%3)));
                    make.top.equalTo(@((i/3+1)+((40-3)/3)*(i/3)));
                    make.width.height.equalTo(@((40-3)/3));
                    
                }];
            }
                break;
            default:
                break;
        }
        
    }
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xDDDDDD);
        XSViewBorderRadius(_backView, 4, 0, KHEXRGB(0xDDDDDD));
    }
    return _backView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"Weiss的家庭组";
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (NSMutableArray *)headImageArr {
    if (!_headImageArr) {
        _headImageArr = [[NSMutableArray alloc] init];
    }
    return _headImageArr;
}

@end
