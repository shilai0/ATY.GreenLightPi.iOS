//
//  ATYAlignmentLabel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "ATYAlignmentLabel.h"

@implementation ATYAlignmentLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textVerticalAlignment = VerticalAlignmentTypeMiddle;
    }
    return self;
}

- (void)setTextVerticalAlignment:(VerticalAlignmentType)textVerticalAlignment {
    _textVerticalAlignment = textVerticalAlignment;
    
    [self setNeedsLayout];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.textVerticalAlignment) {
        case VerticalAlignmentTypeTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentTypeBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentTypeMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
