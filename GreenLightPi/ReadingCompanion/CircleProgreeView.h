//
//  CircleProgreeView.h
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleProgreeView : UIView


@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic, strong) UIColor * defaultBorderColor;
@property (nonatomic, strong) UILabel * messageLbl;
@property (nonatomic, assign) CGFloat value;

-(void)reset;

@end

NS_ASSUME_NONNULL_END
