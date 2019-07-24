//
//  CustomAlertView.m
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/1/17.
//

#import "CustomAlertView.h"


#define ALERTWIDTH (([UIScreen mainScreen].bounds.size.width) * 0.7)
#define BUTTONWIDTH 100
#define BUTTONHEIGHT 50
#define ALERTHEIGHT 150
#define SPACE 10.0
#define ALPHA 0.7
@interface CustomAlertView ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UITextView *title;
@property (nonatomic,strong) UITextView *message;
@end

@implementation CustomAlertView
{
    BOOL isShow;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message submessage:(NSString *)submessage confirmBtn:(NSString *)confirmTitle cancleBtn:(NSString *)cancleTitle{
    
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:ALPHA];
        self.backgroundColor = [UIColor clearColor];
        [self initViewsTitle:title message:message submessage:submessage confirmBtn:confirmTitle cancleBtn:cancleTitle];
    }
    
    return self;
}

-(instancetype)initWithTitle:(NSString *__nullable)title message:(NSString *__nullable)message image:(UIImage *__nullable)image submessage:(NSString *)submessage confirmBtn:(NSString *__nullable)confirmTitle cancleBtn:(NSString *__nullable)cancleTitle{
    
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:ALPHA];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//        [self addGestureRecognizer:tap];
        [self initViewsTitle:title message:message image:image submessage:submessage confirmBtn:confirmTitle cancleBtn:cancleTitle];
    }
    return self;
}

-(instancetype)initWithBgImage:(UIImage *__nullable)image ContentImage:(UIImage *__nullable)conImage  message:(NSString *__nullable)message{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:ALPHA];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//        tap.delegate = self;
//        [self addGestureRecognizer:tap];
        [self initViewsBgImage:image ContentImage:conImage message:message];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(void)initViewsTitle:(NSString *)title message:(NSString *)message submessage:(NSString *)submessage confirmBtn:(NSString *)confirmTitle cancleBtn:(NSString *)cancleTitle{
    
    int width = ALERTWIDTH;
    if (ALERTWIDTH > 350) {
        width = 350;
    }
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 150)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 5.0;
    [self addSubview:_alertView];
    
    UILabel *titleLbl = nil;
    int height = 0;
    if (title) {
        titleLbl = [self getAdaptiveLable:CGRectMake(SPACE, 2*SPACE, width - 2*SPACE, 20) AndText:title andIsTitle:YES];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:titleLbl];
        height = CGRectGetMaxY(titleLbl.frame);
    }
    
    UILabel *messageLbl = nil;
    if (message) {
        messageLbl = [self getAdaptiveLable:CGRectMake(SPACE, height + 2*SPACE, width - 2*SPACE , 20) AndText:message andIsTitle:NO];
        messageLbl.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:messageLbl];
        height = CGRectGetMaxY(messageLbl.frame);
    }
    
    UILabel *submessageLbl = nil;
    if (submessage) {
        submessageLbl = [self getAdaptiveLable:CGRectMake(SPACE, height + SPACE, width - 2*SPACE, 20) AndText:submessage andIsTitle:NO];
        submessageLbl.textColor = [UIColor redColor];
        [_alertView addSubview:submessageLbl];
        height = CGRectGetMaxY(submessageLbl.frame);
    }
    
    UIButton *confirmBtn = nil;
    UIButton *cancleBtn = nil;
    if (confirmTitle && cancleTitle) {
        cancleBtn = [self getButton:CGRectMake((width - 200)/3.0, height + 2*SPACE, BUTTONWIDTH, BUTTONHEIGHT) AndText:cancleTitle];
        cancleBtn.tag = 100;
        confirmBtn = [self getButton:CGRectMake((width - 200)/3.0 *2 + 100, height + 2*SPACE, BUTTONWIDTH, BUTTONHEIGHT) AndText:confirmTitle];
        confirmBtn.tag = 101;
        [confirmBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:cancleBtn];
        [_alertView addSubview:confirmBtn];
        height = CGRectGetMaxY(cancleBtn.frame);
    }else if(confirmTitle){
        confirmBtn = [self getButton:CGRectMake(width/2.0 - BUTTONWIDTH/2.0, height + 2*SPACE, BUTTONWIDTH, BUTTONHEIGHT) AndText:confirmTitle];
        confirmBtn.tag = 101;
        [confirmBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:confirmBtn];
        height = CGRectGetMaxY(confirmBtn.frame);
    }else if (cancleTitle){
        cancleBtn = [self getButton:CGRectMake(width/2.0 - BUTTONWIDTH/2.0, height + 2*SPACE, BUTTONWIDTH, BUTTONHEIGHT) AndText:cancleTitle];
        cancleBtn.tag = 100;
        [cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:cancleBtn];
        height = CGRectGetMaxY(cancleBtn.frame);
    }
    
    _alertView.frame = CGRectMake(0, 0, width, height+2*SPACE);
    _alertView.layer.position = self.center;
}


-(void)initViewsTitle:(NSString *__nullable)title message:(NSString *__nullable)message image:(UIImage *__nullable)image submessage:(NSString *)submessage confirmBtn:(NSString *__nullable)confirmTitle cancleBtn:(NSString *__nullable)cancleTitle{
    
    int width = ALERTWIDTH;
    if (ALERTWIDTH > 400) {
        width = 400;
    }
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 150)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 10.0;
    _alertView.layer.masksToBounds = YES;
    [self addSubview:_alertView];
    
    
    UILabel *titleLbl = nil;
    int height = 0;
    if (title) {
        titleLbl = [self getAdaptiveLable:CGRectMake(SPACE, 2*SPACE, width - 2*SPACE, 30) AndText:title andIsTitle:YES];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.font = [UIFont systemFontOfSize:30];
        titleLbl.textColor = [UIColor blackColor];
        [_alertView addSubview:titleLbl];
        height = CGRectGetMaxY(titleLbl.frame);
    }
    UILabel *messageLbl = nil;
    if (message) {
        messageLbl = [self getAdaptiveLable:CGRectMake(SPACE, height + 2*SPACE, width - 2*SPACE , 20) AndText:message andIsTitle:NO];
        messageLbl.textColor = [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1];
        messageLbl.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:messageLbl];
        height = CGRectGetMaxY(messageLbl.frame);
    }
    UIImageView *imgV = nil;
    if (image) {
        imgV = [[UIImageView alloc]initWithFrame:CGRectMake(SPACE+10, height + SPACE+10, width - 2*(SPACE+10),width*1.2)];
        [imgV setImage:image];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [_alertView addSubview:imgV];
        height = CGRectGetMaxY(imgV.frame);
    }
    UILabel *submessageLbl = nil;
    if (submessage) {
        submessageLbl = [self getAdaptiveLable:CGRectMake(SPACE, height + SPACE, width - 2*SPACE, 20) AndText:submessage andIsTitle:NO];
        submessageLbl.textColor = [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1];
        [_alertView addSubview:submessageLbl];
        height = CGRectGetMaxY(submessageLbl.frame);
    }
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(SPACE+10, height+SPACE , width - 2*(SPACE+10), 1)];
    line.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
    [_alertView addSubview:line];
    height = CGRectGetMaxY(line.frame);
    
    UIButton *confirmBtn = nil;
    UIButton *cancleBtn = nil;
    if (confirmTitle && cancleTitle) {
        cancleBtn = [self getButton:CGRectMake((width - 300)/3.0, height + 2*SPACE, 150, height/11) AndText:cancleTitle];
        cancleBtn.tag = 100;
        confirmBtn = [self getButton:CGRectMake((width - 300)/3.0 *2 + 100, height + 2*SPACE, 150, height/11) AndText:confirmTitle];
        confirmBtn.tag = 101;
        [confirmBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:cancleBtn];
        [_alertView addSubview:confirmBtn];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        cancleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        height = CGRectGetMaxY(cancleBtn.frame);
    }else if(confirmTitle){
        confirmBtn = [self getButton1:CGRectMake(width/2.0 - 150/2.0, height + 2*SPACE, 150, height/11) AndText:confirmTitle];
        confirmBtn.tag = 101;
        [confirmBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:confirmBtn];
        height = CGRectGetMaxY(confirmBtn.frame);
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    }else if (cancleTitle){
        cancleBtn = [self getButton1:CGRectMake(width/2.0 - 150/2.0, height + 2*SPACE, 150, height/11) AndText:cancleTitle];
        cancleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        cancleBtn.tag = 100;
        [cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:cancleBtn];
        height = CGRectGetMaxY(cancleBtn.frame);
    }
    
    _alertView.frame = CGRectMake(0, 0, width, height+2*SPACE);
    _alertView.layer.position = self.center;
}


-(void)initViewsBgImage:(UIImage *__nullable)image ContentImage:(UIImage *__nullable)conImage message:(NSString *__nullable)message{
    int width = ALERTWIDTH;
    if (ALERTWIDTH > 400) {
        width = 400;
    }
    int height = width *1.37;
    if (conImage == nil) {
        height = width *1.52;
    }
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _alertView.backgroundColor = [UIColor clearColor];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:_alertView.frame];
    imageV.image = image ;//[UIImage imageNamed:@"qrcodebg"];
    [_alertView addSubview:imageV];
    [self addSubview:_alertView];
    
    int imageVheight = height * 550 /850 - 50 -SPACE;
    
    UIImageView *imgV = nil;
    if (conImage) {
        imgV = [[UIImageView alloc]initWithFrame:CGRectMake((width - imageVheight)/2, height *300 /850 + 5, imageVheight, imageVheight)];
        [imgV setImage:conImage];
        [_alertView addSubview:imgV];
    }
    UILabel *messageLbl = nil;
    if (message) {
        messageLbl = [self getAdaptiveLable:CGRectMake((width - imageVheight)/2, CGRectGetMaxY(imgV.frame), imageVheight , 40) AndText:message andIsTitle:NO];
        messageLbl.numberOfLines = 1;
        messageLbl.font = [UIFont systemFontOfSize:16.0];
        messageLbl.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:messageLbl];
    }
    
    UIButton * cancleBtn = [self getButton1:CGRectMake(width/2.0 - 150/2.0, height + 4*SPACE, 150, BUTTONHEIGHT) AndText:@""];
    [cancleBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    cancleBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cancleBtn.tag = 100;
    [cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:cancleBtn];
    height = CGRectGetMaxY(cancleBtn.frame);
    _alertView.frame = CGRectMake(0, 0, width, height+2*SPACE);
    _alertView.layer.position = CGPointMake(self.center.x, self.center.y + 2 *SPACE);
}

-(void)tapAction{
    [self removeFromSuperview];
}




-(UIButton *)getButton:(CGRect)rect AndText:(NSString *)contentStr{
    UIButton * btn = [UIButton buttonWithType:0];
    btn.frame = rect;
    btn.titleLabel.text = contentStr;
    [btn setTitle:contentStr forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:40/255.0 green:170/255.0 blue:245/255.0 alpha:1.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5.0;
    return btn;
}
-(UIButton *)getButton1:(CGRect)rect AndText:(NSString *)contentStr{
    UIButton * btn = [UIButton buttonWithType:0];
    btn.frame = rect;
    btn.titleLabel.text = contentStr;
    [btn setTitle:contentStr forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:22];
    return btn;
}

-(UILabel *)getAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:20.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:18.0];
    }
    contentLbl.adjustsFontSizeToFitWidth = YES;
    //    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    //    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    //    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //    [mParaStyle setLineSpacing:3.0];
    //    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    //    [contentLbl setAttributedText:mAttrStr];
    //    [contentLbl sizeToFit];
    
    return contentLbl;
}


-(void)showAlertView:(UIView *)view{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!isShow) {
            [view addSubview:self];
            isShow = YES;
            [self createShowAnimation];
        }
    });
}

-(void)createShowAnimation{
    
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark --------UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self]) {
        return NO;
    }
    return YES;
}


#pragma mark - 回调
- (void)buttonEvent:(UIButton *)sender
{
    if (self.resultIndex) {
        self.resultIndex(sender.tag);
    }
    isShow = NO;
    [self removeFromSuperview];
}

-(void)dismissAlertView{
    isShow = NO;
    [self removeFromSuperview];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
