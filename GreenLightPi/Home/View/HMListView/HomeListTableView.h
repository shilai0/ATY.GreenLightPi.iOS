//
//  HomeListTableView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

typedef NS_ENUM(NSInteger,ListViewType){
    ListViewTypeDefault = 0, //
    ListViewTypeAttention,//
};

@interface HomeListTableView : BaseTableView
@property (nonatomic, assign) ListViewType listViewType;
@end
