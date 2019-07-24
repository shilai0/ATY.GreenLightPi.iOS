//
//  RightView.h
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/5/14.
//

#import <UIKit/UIKit.h>
#import "CircleProgreeView.h"
NS_ASSUME_NONNULL_BEGIN
@class VTSDKBookDataModel;


typedef void(^BtnAction)(UIButton *);
@interface RightView : UIView

@property (nonatomic, copy) BtnAction btnAction;
@property (nonatomic, strong) CircleProgreeView *progressView;
@property (nonatomic, strong) UILabel * playBtnName;

-(void)addPreview:(UIView *)preview;
-(void)updateViews:(VTSDKBookDataModel *)model;
-(void)changeUI:(int)type;
@end

NS_ASSUME_NONNULL_END
