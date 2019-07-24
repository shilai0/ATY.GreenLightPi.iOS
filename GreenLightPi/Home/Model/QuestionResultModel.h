//
//  QuestionResultModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/13.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

//"answers_id": 1,
//"title": "sample string 2",
//"content": "sample string 3",
//"answer_number": 4,
//"collect_number": 5,
//"comment": "sample string 6",
//"read_count": 7,
//"audit_status": 8,
//"imagelist": [
//              {
//                  "file_id": 1,
//                  "path": "sample string 2",
//                  "grade_code": "sample string 3",
//                  "sort_no": 4,
//                  "filetype_id": 5,
//                  "filetype_name": "sample string 6"
//              },
//              {
//                  "file_id": 1,
//                  "path": "sample string 2",
//                  "grade_code": "sample string 3",
//                  "sort_no": 4,
//                  "filetype_id": 5,
//                  "filetype_name": "sample string 6"
//              }
//              ]
//}
@class FileEntityModel;
@interface QuestionResultModel : NSObject
@property (nonatomic, copy) NSNumber *answers_id;
@property (nonatomic, copy) NSNumber *answer_number;
@property (nonatomic, copy) NSNumber *collect_number;
@property (nonatomic, copy) NSNumber *read_count;
@property (nonatomic, copy) NSNumber *audit_status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *Ctime;//创建
@property (nonatomic, strong) NSArray *imagelist;
@property (nonatomic, copy) NSNumber *is_collect;//是否已收藏 0 未收藏 1已收藏 ,
@end
