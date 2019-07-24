//
//  HomePureTextCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/2/15.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HomePureTextCell.h"
#import "HomeListModel.h"

@interface HomePureTextCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *authorButton;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation HomePureTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatPureTextCellViews];
    }
    return self;
}

- (void)creatPureTextCellViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.authorButton];
    [self.contentView addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView.mas_left).offset(-15);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.height.equalTo(@20);
    }];
    
    [self.authorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(9);
        make.height.equalTo(@12);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.authorButton.mas_bottom).offset(11);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
}

-(void)setListModel:(HomeListModel *)listModel {
    _listModel = listModel;
    self.titleLabel.text = _listModel.title;
    self.typeLabel.text = _listModel.articletype.typename;
    [self.authorButton setTitle:_listModel.author forState:UIControlStateNormal];
    
    if ([_listModel.is_red integerValue] != 1) {
        self.typeLabel.hidden = YES;
    } else {
        self.typeLabel.hidden = NO;
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIButton *)authorButton {
    if (!_authorButton) {
        _authorButton = [[UIButton alloc] init];
        [_authorButton setImage:[UIImage imageNamed:@"home_ author"] forState:UIControlStateNormal];
        _authorButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_authorButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
    }
    return _authorButton;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.layer.borderColor = [KHEXRGB(0x44C08C) CGColor];
        _typeLabel.layer.borderWidth = 0.5f;
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.textColor = KHEXRGB(0x44C08C);
    }
    return _typeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

@end
