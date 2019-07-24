//
//  FileEntityModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/15.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

//FileEntityModel {
//    file_id (integer, optional): 文件id ,
//    path (string, optional): 文件路径 ,
//    grade_code (string, optional): 文件组 ,
//    sort_no (integer, optional): 文件排序 ,
//    filetype_id (integer, optional): 文件类型id ,
//    filetype_name (string, optional): 文件类型名称
//}
@interface FileEntityModel : NSObject
@property (nonatomic, copy) NSNumber *file_id;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *grade_code;
@property (nonatomic, copy) NSNumber *sort_no;
@property (nonatomic, copy) NSString *filetype_name;
@property (nonatomic, copy) NSNumber *filetype_id;
@end

