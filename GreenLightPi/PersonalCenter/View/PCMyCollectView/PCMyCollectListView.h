//
//  PCMyCollectListView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

typedef NS_ENUM(NSInteger,SelectShowType){
    SelectShowTypeDefault = 0, //收藏
    SelectShowTypeBrows,//浏览历史
};

@interface PCMyCollectListView : BaseTableView
@property (nonatomic, assign) SelectShowType type;
@property (nonatomic, strong) NSMutableArray *currentDataArr;
@property (nonatomic, assign) NSInteger switchIndex;
@end
