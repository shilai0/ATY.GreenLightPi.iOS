//
//  CircleProgreeView.m
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/5/14.
//

#import "CircleProgreeView.h"

@interface CircleProgreeView ()

@property (nonatomic, assign) double progress;
@property (nonatomic, assign) CFTimeInterval animationDuration;
@property (nonatomic, strong) CAShapeLayer *bgLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation CircleProgreeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
        [self initData];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.messageLbl.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height /3.0);
     [self initLayers];
}

#pragma mark ---private methods------
-(void)initData{
    self.borderColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:0 alpha:1];
    self.defaultBorderColor = [UIColor lightGrayColor];
    self.borderWidth = 10;
}

-(void)initView{
    self.messageLbl = [[UILabel alloc]init];
    self.messageLbl.font = [UIFont systemFontOfSize:18];
    self.messageLbl.text = @"正在加载，请稍等...";
    self.messageLbl.textAlignment = NSTextAlignmentCenter;
    self.messageLbl.textColor = [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1];
    [self addSubview:self.messageLbl];
}

-(void)initLayers{
    int width = self.bounds.size.height *2/3 -15;
    CGRect rect = CGRectMake((self.bounds.size.width - width)/2, CGRectGetMaxY(self.messageLbl.frame)+5 , width, width);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, width-10, width-10)];
    if (self.bgLayer == nil) {
         self.bgLayer = [CAShapeLayer layer];
    }
    self.bgLayer.frame = rect;
    self.bgLayer.fillColor = [UIColor clearColor].CGColor;
    self.bgLayer.lineWidth = self.borderWidth;
    self.bgLayer.strokeColor = self.defaultBorderColor.CGColor;
    self.bgLayer.strokeStart = 0.f;
    self.bgLayer.strokeEnd = 1.f;
    self.bgLayer.path = path.CGPath;
    [self.layer addSublayer:self.bgLayer];
    
    if (self.shapeLayer == nil) {
        self.shapeLayer = [CAShapeLayer layer];
    }
    self.shapeLayer.frame = rect;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.lineWidth = self.borderWidth;
    self.shapeLayer.strokeColor = self.borderColor.CGColor;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.strokeStart = 0.f;
    self.shapeLayer.strokeEnd = 0.f;
    [self.shapeLayer setAffineTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    self.shapeLayer.path = path.CGPath;
    [self.layer addSublayer:self.shapeLayer];
}

-(void)reset{
    if (self.shapeLayer.strokeEnd!=0 || self.shapeLayer.strokeStart!=0) {
        self.shapeLayer.strokeStart = 0.f;
        self.shapeLayer.strokeEnd = 0.f;
        self.hidden = YES;
    }
}

#pragma mark -----getter and setter -----
-(void)setValue:(CGFloat)value{
    _value = value;
    self.shapeLayer.strokeEnd = value;
}


@end
