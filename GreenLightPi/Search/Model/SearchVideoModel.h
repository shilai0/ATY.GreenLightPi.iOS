//
//  SearchVideoModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchVideoModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *searchType;
@property (nonatomic, strong) NSArray *data;
@end
