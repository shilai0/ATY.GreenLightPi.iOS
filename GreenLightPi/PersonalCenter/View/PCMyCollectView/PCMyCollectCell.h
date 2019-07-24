//
//  PCMyCollectCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/27.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectModel,BrowseModel;
@interface PCMyCollectCell : UITableViewCell
@property (nonatomic, strong) CollectModel *collectModel;
@property (nonatomic, strong) BrowseModel *browseTypeModel;
@end
