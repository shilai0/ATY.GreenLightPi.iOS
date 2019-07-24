//
//  FCCourseDetailBottomView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCourseDetailBottomView.h"

@interface FCCourseDetailBottomView ()
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation FCCourseDetailBottomView

-(instancetype)initWithData:(NSArray *)btnArr {
    if ([super init]) {
        [self fc_creatBottomView:btnArr];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)fc_creatBottomView:(NSArray *)btnArr {
    for (int i = 0; i < btnArr.count; i ++) {
        /**
         NSMutableArray *btnArr = [NSMutableArray arrayWithObjects:@{@"imageName":@"fc_wantStudy",@"title":@"想学",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xFFFFFF)}, @{@"imageName":@"",@"title":@"VIP免费",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xD9D295)},@{@"imageName":@"fc_addStudy",@"title":@"加入学习",@"titleColor":@"0xFFFFFF",@"backColor":KHEXRGB(0x44C08C)},nil];
         **/
        NSDictionary *btnDic = btnArr[i];
        self.bottomBtn = [UIButton new];
        self.bottomBtn.tag = 10 + i;
        [self.bottomBtn setImage:[UIImage imageNamed:btnDic[@"imageName"]] forState:UIControlStateNormal];
        [self.bottomBtn setTitle:btnDic[@"title"] forState:UIControlStateNormal];
        self.bottomBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        if (i == 0) {
            [self.bottomBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
            [self.bottomBtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
            NSString *imageName = btnDic[@"imageName"];
            if (imageName.length > 0) {
                [self.bottomBtn setImage:[UIImage imageNamed:@"fc_wantStudy_selected"] forState:UIControlStateSelected];
            }
        } else if (i == 1) {
            [self.bottomBtn setBackgroundColor:KHEXRGB(0xD9D295)];
            [self.bottomBtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
        } else if (i == 2) {
            [self.bottomBtn setBackgroundColor:KHEXRGB(0x44C08C)];
            [self.bottomBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        }
        [self addSubview:self.bottomBtn];
        
        @weakify(self);
        [[self.bottomBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (i == 0) {
                UIButton *bottomBtn = [self viewWithTag:10];
                bottomBtn.selected = !bottomBtn.selected;
                if (self.atyClickActionBlock) {
                    self.atyClickActionBlock(i, [NSString stringWithFormat:@"%@",[NSNumber numberWithBool:bottomBtn.selected]], nil);
                }
            } else {
                if (self.atyClickActionBlock) {
                    self.atyClickActionBlock(i, nil, nil);
                }
            }
        }];
    }
    
    for (int i = 0; i < btnArr.count; i ++) {
        UIButton *bottomBtn = [self viewWithTag:10 + i];
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@((KSCREEN_WIDTH/btnArr.count)*i));
            make.bottom.equalTo(self);
            make.width.equalTo(@(KSCREEN_WIDTH/btnArr.count));
            make.height.equalTo(@49);
        }];
    }
}

@end
