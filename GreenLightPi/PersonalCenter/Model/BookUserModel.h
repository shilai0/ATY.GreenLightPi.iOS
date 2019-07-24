//
//  BookUserModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/27.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 bookList (Array[FatherStudyContentModel], optional),
 userId (integer, optional),
 imagePath (string, optional),
 name (string, optional),
 nikeName (string, optional),
 label (string, optional),
 fansCount (integer, optional),
 worksCount (integer, optional),
 isFollow (integer, optional),
 resume (string, optional)
 */
@class FatherStudyContentModel;
@interface BookUserModel : NSObject
@property (nonatomic, strong) NSArray *bookList;
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSNumber *fansCount;
@property (nonatomic, copy) NSNumber *worksCount;
@property (nonatomic, copy) NSNumber *isFollow;
@property (nonatomic, copy) NSString *resume;
@end
