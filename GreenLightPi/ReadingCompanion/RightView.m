//
//  RightView.m
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/5/14.
//

#import "RightView.h"
//#import <Masonry.h>
#import "UIImageView+WebCache.h"
#import "ReadButton+EnlargeHitArea.h"
#import "VTPictureBookSDK.framework/Headers/VTSDKBookDataModel.h"
#import "ReadButton.h"

#define Space 100*2
#define WIDTH [UIScreen mainScreen].bounds.size.width

API_AVAILABLE(ios(9.0))
@interface RightView ()


@property(nonatomic, strong) UIButton *settingsBtn;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UIImageView * preView;
@property (nonatomic, strong) UILabel *publishLbl;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *messageLbl;
@property (nonatomic, strong) UIStackView *btnStackView;
@property (nonatomic, strong) UIView *cameraView;
@property (nonatomic, strong) UIView *bottomV;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *replayBtn;
@property (nonatomic, strong) UIView *bottomBg;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) UILabel *name_trail;
@end

@implementation RightView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}


-(void)initViews{
    _isShow = NO;
    UIImageView *imagebg = [[UIImageView alloc]initWithFrame:self.bounds];
    imagebg.userInteractionEnabled = YES;
    
    UIImage *img = [UIImage imageNamed:@"bg"];
    [img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height *0.45, img.size.width *0.45, img.size.height *0.45, img.size.width *0.45) resizingMode:UIImageResizingModeStretch];
    [imagebg setImage:img];
    [self addSubview:imagebg];
    
//    UIView *settingBg = [[UIView alloc]init];
//    settingBg.backgroundColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:0/255.0 alpha:1];
//    settingBg.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:225/255.0 blue:100/255.0 alpha:1].CGColor;
//    settingBg.layer.shadowRadius = 5;
//    settingBg.layer.shadowOffset = CGSizeMake(1, 5);
//    settingBg.layer.shadowOpacity = 0.8;
//    [self addSubview:settingBg];
    
    //    self.line = [[UIImageView alloc]init];
    //    self.line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    //    [self addSubview:self.line];
    
    self.preView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    self.preView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.preView];
    
    UIStackView *containerV = [[UIStackView alloc]init];
    containerV.axis = UILayoutConstraintAxisVertical;
    containerV.distribution = UIStackViewDistributionFillEqually;
    [self addSubview:containerV];
    
    UIView *btnView = [[UIView alloc]init];
    [containerV addArrangedSubview:btnView];
    
    UIView *bottomV = [[UIView alloc]init];
    [containerV addArrangedSubview:bottomV];
    bottomV.clipsToBounds = YES;
    self.bottomV = bottomV;
    
    UIView *bottomBg = [[UIView alloc]init];
    bottomBg.backgroundColor = [UIColor whiteColor];
    bottomBg.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:225/255.0 blue:100/255.0 alpha:1].CGColor;
    bottomBg.layer.shadowRadius = 3;
    bottomBg.layer.shadowOffset = CGSizeMake(1, 1);
    bottomBg.layer.shadowOpacity = 0.6;
    [bottomV addSubview:bottomBg];
    self.bottomBg = bottomBg;
    //播放按钮界面
    ReadButton *playBtn = [ReadButton buttonWithType:0];
    playBtn.tag = 1000;
    playBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
    playBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
    [playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1] forState:UIControlStateNormal];
    self.playBtn = playBtn;
    [self.playBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * playBtnName = [[UILabel alloc]init];
    playBtnName.text = @"暂停";
    playBtnName.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1] ;
    playBtnName.adjustsFontSizeToFitWidth = YES;
    playBtnName.font = [UIFont systemFontOfSize:18];
    playBtnName.textAlignment = NSTextAlignmentCenter;
    playBtnName.tag = 99;
    self.playBtnName = playBtnName;
    UILabel * replayBtnName = [[UILabel alloc]init];
    replayBtnName.text = @"重读";
    replayBtnName.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1] ;
    replayBtnName.adjustsFontSizeToFitWidth = YES;
    replayBtnName.font = [UIFont systemFontOfSize:18];
    replayBtnName.textAlignment = NSTextAlignmentCenter;
    replayBtnName.tag = 98;
    ReadButton *replayBtn = [ReadButton buttonWithType:0];
    replayBtn.tag = 1001;
    replayBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
    replayBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [replayBtn setImage:[UIImage imageNamed:@"replay"] forState:UIControlStateNormal];
    [replayBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [replayBtn setTitleColor:[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1] forState:UIControlStateNormal];
    self.replayBtn = replayBtn;
    
    UIView *playV = [[UIView alloc]init];
    UIView *replayV = [[UIView alloc]init];
    [playV addSubview:playBtn];
    [playV addSubview:playBtnName];
    [replayV addSubview:replayBtn];
    [replayV addSubview:replayBtnName];
    
    UIStackView *btnStackView = [[UIStackView alloc]initWithArrangedSubviews:@[playV,replayV]];
    btnStackView.axis = UILayoutConstraintAxisHorizontal;
    btnStackView.distribution = UIStackViewDistributionFillEqually;
    btnStackView.hidden = YES;
    [btnView addSubview:btnStackView];
    self.btnStackView = btnStackView;
    
    //进度条界面
    self.progressView = [[CircleProgreeView alloc]init];
    self.progressView.hidden = YES;
    [btnView addSubview:self.progressView];
    
    //提示
    self.messageLbl = [[UILabel alloc]init];
    self.messageLbl.text = @"请把封面放桌上";
//    self.messageLbl.hidden = YES;
    self.messageLbl.textAlignment = NSTextAlignmentCenter;
    self.messageLbl.textColor = [UIColor colorWithRed:4/255.0 green:4/255.0 blue:4/255.0 alpha:1];
    
    self.messageLbl.adjustsFontSizeToFitWidth = YES;
    [btnView addSubview:self.messageLbl];
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AppIcon"]];
    imageV.contentMode = UIViewContentModeScaleToFill;
    [bottomBg addSubview:imageV];
    self.imageV = imageV;
    
    UILabel *name_trail = [[UILabel alloc]init];
    name_trail.text = @"》";
    name_trail.textColor = [UIColor colorWithRed:4/255.0 green:4/255.0 blue:4/255.0 alpha:1];
    [bottomBg addSubview:name_trail];
    self.name_trail = name_trail;
    
    self.titleLbl = [[UILabel alloc]init];
    self.titleLbl.textColor = [UIColor colorWithRed:4/255.0 green:4/255.0 blue:4/255.0 alpha:1];
    self.titleLbl.text = @"";
    self.titleLbl.numberOfLines=1;
    self.titleLbl.font = FONT(20);
    [bottomBg addSubview:self.titleLbl];
    
    UILabel *publishLbl = [[UILabel alloc]init];
    publishLbl.text = @"出版社：";
    publishLbl.numberOfLines=1;
    publishLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    publishLbl.textColor = [UIColor lightGrayColor];
    self.publishLbl = publishLbl;
    
    UILabel *name = [[UILabel alloc]init];
    name.text = @"作者：";
    name.numberOfLines=1;
    name.textColor = [UIColor lightGrayColor];
    name.lineBreakMode = NSLineBreakByTruncatingTail;
    self.name = name;
    
    if (IS_IPHONE) {
        self.messageLbl.font = [UIFont systemFontOfSize:18];// FONT(16);
        self.titleLbl.font = FONT(16);
        name_trail.font = FONT(16);
        publishLbl.font = FONT(11);
        name.font = FONT(11);
        playBtnName.font = FONT(11);
        replayBtnName.font = FONT(11);
        self.progressView.messageLbl.font = FONT(13);
        self.progressView.borderWidth = 5;
    }else{
        self.messageLbl.font = FONT(15);
        self.titleLbl.font = FONT(15);
        name_trail.font = FONT(15);
        publishLbl.font = FONT(9);
        name.font = FONT(9);
        playBtnName.font = FONT(9);
        replayBtnName.font = FONT(9);
        self.progressView.messageLbl.font = FONT(9);
    }
    
    UIStackView *describeV = [[UIStackView alloc]initWithArrangedSubviews:@[publishLbl,name]];
    describeV.axis = UILayoutConstraintAxisVertical;
    describeV.distribution = UIStackViewDistributionFillEqually;
    [bottomBg addSubview:describeV];
    
    int height = [UIScreen mainScreen].bounds.size.height*0.6;
    int width =( height*0.75 < [UIScreen mainScreen].bounds.size.width - 20)?height *0.75 : [UIScreen mainScreen].bounds.size.width*0.9;
    
//    [settingBg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(self);
//        make.height.mas_equalTo(self.mas_width).multipliedBy(NATIVE_HEAD_HEIGHT);
//    }];
    
    
    [self.preView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(width);
        make.top.mas_equalTo(@(20+KTopBarSafeHeight));
        make.height.mas_equalTo(self.preView.mas_width).multipliedBy(4.0/3);
    }];
    
    [containerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.preView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self).mas_offset(-25);
    }];
    
    [btnStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(btnView);
        make.width.mas_equalTo(self.preView.mas_width);
        make.top.mas_equalTo(btnView);
        make.bottom.mas_equalTo(btnView);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(btnView);
        make.width.mas_equalTo(self.preView.mas_width);
        make.top.mas_equalTo(btnView);
        make.bottom.mas_equalTo(btnView);
    }];
    
    [self.messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(btnView);
        make.width.mas_equalTo(self.preView.mas_width);
        make.top.mas_equalTo(btnView);
        make.bottom.mas_equalTo(btnView);
    }];
    
    [bottomBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomV.mas_bottom);
        make.height.mas_equalTo(bottomV.mas_height).mas_offset(-5);
        make.left.mas_equalTo(bottomV).mas_offset(20);
        make.right.mas_equalTo(bottomV).mas_offset(-20);
    }];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomBg).mas_offset(5);
        make.bottom.mas_equalTo(bottomBg).mas_offset(-5);
        make.left.mas_equalTo(bottomBg).mas_offset(5);
        make.width.mas_equalTo(imageV.mas_height);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV);
        make.left.mas_equalTo(imageV.mas_right).mas_offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(imageV.mas_height).multipliedBy(0.45);
    }];
    
    [name_trail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLbl.mas_top);
        make.left.mas_equalTo(self.titleLbl.mas_right);
        make.right.mas_equalTo(bottomBg);
        make.height.mas_equalTo(self.titleLbl.mas_height);
    }];
    
    
    [describeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLbl.mas_bottom);
        make.bottom.mas_equalTo(imageV);
        make.left.mas_equalTo(imageV.mas_right).mas_offset(13);
        make.right.mas_equalTo(bottomBg).offset(-10);
    }];
    [playBtnName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(playV);
        make.bottom.mas_equalTo(playV).offset(-10);
        make.height.mas_equalTo(playV).multipliedBy(0.25);
    }];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.right.mas_equalTo(playV);
        make.top.mas_equalTo(playV).offset(5);
        make.bottom.mas_equalTo(playBtnName.mas_top);
        make.centerX.mas_equalTo(playV);
        make.width.mas_equalTo(playBtn.mas_height);
    }];
    [replayBtnName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(playBtnName);
        make.left.right.mas_equalTo(replayV);
        make.bottom.mas_equalTo(replayV).offset(-10);
    }];
    [replayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.right.mas_equalTo(replayV);
        make.centerX.mas_equalTo(replayV);
        make.top.mas_equalTo(replayV).offset(5);
        make.width.height.mas_equalTo(playBtn);
        //        make.bottom.mas_equalTo(replayBtnName.mas_top);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //    CGFloat fontNumber = self.imageV.bounds.size.height*0.5 ;
    //    self.titleLbl.font = [UIFont systemFontOfSize:fontNumber*0.65];
    //    self.publishLbl.font = [UIFont systemFontOfSize:fontNumber*0.5*0.8];
    //    self.name.font = [UIFont systemFontOfSize:fontNumber*0.5*0.8];
    //    UILabel *playLbl = [self viewWithTag:99];
    //    playLbl.font = [UIFont systemFontOfSize:fontNumber*0.5*0.8];
    //    UILabel *replayLbl = [self viewWithTag:98];
    //    replayLbl.font = [UIFont systemFontOfSize:fontNumber*0.5*0.8];
    //    int w1 = _playBtn.bounds.size.width;
    //    int h1 = _playBtn.bounds.size.height;
    //    int imgH = (w1 < h1?w1:h1)*0.8;
    //    int space = _playBtn.bounds.size.width - imgH;
    //    self.playBtn.backgroundColor = [UIColor redColor];
    //    [self.playBtn setImageEdgeInsets:UIEdgeInsetsMake(0, space/2 ,0, space/2)];
    //    [_replayBtn setImageEdgeInsets:UIEdgeInsetsMake(0, space/2, 0,  space/2)];
}

#pragma mark ----private methods------

-(void) addPreview:(UIView *)preview{
    self.cameraView = preview;
    self.cameraView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.preView addSubview:self.cameraView];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"previewbg"]];
    bgImg.contentMode = UIViewContentModeScaleToFill;
    [self.preView addSubview:bgImg];
    
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.mas_equalTo(self.preView);
    }];
    
    [self.cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.preView.mas_height).multipliedBy(0.93);
        make.height.mas_equalTo(self.preView.mas_width).multipliedBy(0.98);
        make.width.mas_equalTo(self.preView.mas_height);
//        make.height.mas_equalTo(self.preView.mas_width);
        make.centerX.mas_equalTo(self.preView);
//        make.centerY.mas_equalTo(self.preView).offset(-self.preView.bounds.size.height *0.006);
        make.centerY.mas_equalTo(self.preView);
    }];
    
    
    //    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    //    line.contentMode = UIViewContentModeScaleToFill;
    //    [self.preView addSubview:line];
    
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(1);
//        make.height.mas_equalTo(self.cameraView.mas_width);
//        make.center.mas_equalTo(self.cameraView);
//    }];
}

-(void)updateViews:(VTSDKBookDataModel *)model{
    NSDictionary *bookInfo = model.bookInfo;
    
    int height = self.messageLbl.bounds.size.height;
    UIFont *font = nil;
    if (IS_IPHONE) {
        font = FONT(16);
    }else{
        font = FONT(15);
    }
    if (bookInfo && ![bookInfo isKindOfClass:[NSNull class]]) {
        CGSize trailWidth;
        int width = CGRectGetMinX(self.titleLbl.frame);
        NSString *content = [NSString stringWithFormat:@"《 %@",bookInfo[@"bookName"]];
        trailWidth = [@"》" boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
        int max_width = self.bottomBg.bounds.size.width - width - trailWidth.width;
        CGSize contentWidth = [content boundingRectWithSize:CGSizeMake(max_width, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
        [self.titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(contentWidth.width+5);
        }];
        
        self.titleLbl.text =[NSString stringWithFormat:@"%@",content] ;
        self.publishLbl.text =[NSString stringWithFormat:@"出版社：%@",bookInfo[@"publisher"]];
        self.name.text =[NSString stringWithFormat:@"作    者：%@",bookInfo[@"author"]];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:bookInfo[@"thumbnailCoverImage"]]];
    }
}

-(void)changeUI:(int)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (type) {
            case 1:// nobook
                [self hideBottomV];
                self.btnStackView.hidden = YES;
                self.progressView.hidden = YES;
                self.messageLbl.hidden = NO;
                break;
            case 2:
                self.playBtn.selected = NO;
                [self showBottomV];
                [self.progressView reset];
                self.btnStackView.hidden = NO;
                self.progressView.hidden = YES;
                self.messageLbl.hidden = YES;
                break;
            case 3:
                [self showBottomV];
                self.btnStackView.hidden = YES;
                self.progressView.hidden = NO;
                self.messageLbl.hidden = YES;
                break;
            case 4:
                self.playBtn.selected = NO;
                break;
            default:
                break;
        }
    });
}

-(void)showBottomV{
    if (self.isShow == NO) {
        self.isShow = YES;
        [UIView animateWithDuration:0.5 animations:^{
            [self.bottomBg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_bottomV.mas_bottom).offset(-self.bottomV.bounds.size.height);
            }];
            [self.bottomV layoutIfNeeded];
        }];
        [self setNeedsLayout];
    }
}

-(void)hideBottomV{
    if (self.isShow) {
        self.isShow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            [self.bottomBg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_bottomV.mas_bottom).offset(0);
            }];
            [self.bottomV layoutIfNeeded];
        }];
    }
}

#pragma mark -----private methods----

-(void)btnAction:(UIButton *)btn{
    if (self.btnAction) {
        self.btnAction(btn);
    }
}

@end
