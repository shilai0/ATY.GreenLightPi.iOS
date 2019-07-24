//
//  QRCodeView.m
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/4/17.
//

#import "QRCodeView.h"

@interface QRCodeView ()
@property (nonatomic, strong) UILabel *promptLabel;
@end

@implementation QRCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.scanView = [[SGQRCodeScanView alloc]init];
        [self addSubview:self.scanView];
        self.promptLabel = [[UILabel alloc]init];
        self.promptLabel.backgroundColor = [UIColor clearColor];
        self.promptLabel.textAlignment = NSTextAlignmentCenter;
        self.promptLabel.font = [UIFont boldSystemFontOfSize:15.0];
        self.promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        self.promptLabel.text = @"请扫一扫激活码";
        [self addSubview:self.promptLabel];
        
        self.imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_guild.png"]];
        self.imageV.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.imageV];
        
    }
    return self;
}

-(void) addflashlightBtn{
    if (!self.flashlightBtn) {
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"SGQRCode" withExtension:@"bundle"];
        if (!url) {
            /// 动态库 url 的获取
            url = [[NSBundle bundleForClass:[self class]] URLForResource:@"SGQRCode" withExtension:@"bundle"];
        }
        NSBundle *bundle = [NSBundle bundleWithURL:url];
        
        UIImage *image = [UIImage imageNamed:@"SGQRCodeFlashlightOpenImage" inBundle:bundle compatibleWithTraitCollection:nil];
        UIImage *closeImage = [UIImage imageNamed:@"SGQRCodeFlashlightCloseImage" inBundle:bundle compatibleWithTraitCollection:nil];
        
        [_flashlightBtn setBackgroundImage:image forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:closeImage forState:(UIControlStateSelected)];
        
        [self addSubview:_flashlightBtn];
    }
}

-(void)layoutSubviews{
    self.scanView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGFloat promptLabelX = 0;
    CGFloat promptLabelW = self.frame.size.width;
    CGFloat promptLabelY =  ( self.frame.size.height - promptLabelW*Scale)/2.0 + promptLabelW*Scale + 10;
    CGFloat promptLabelH = 25;
    self.promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    CGFloat flashlightBtnW = 30;
    CGFloat flashlightBtnH = 30;
    CGFloat flashlightBtnX = 0.5 * (self.frame.size.width - flashlightBtnW);
    CGFloat flashlightBtnY =( self.frame.size.height - promptLabelW*Scale)/2.0 + promptLabelW*Scale -  40;
    if (self.flashlightBtn) {
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
    }
    
    int width = promptLabelW *0.4;
    int height = promptLabelW * 0.4 * 1064 / 1428;
    self.imageV.frame = CGRectMake(promptLabelW - width, self.frame.size.height, width, height);
    
}



@end
