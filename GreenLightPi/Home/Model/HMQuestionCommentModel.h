//
//  HMQuestionCommentModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 comment_id (integer, optional): 评论id ,
 content (string, optional): 评论内容 ,
 imageList (Array[FileEntityModel], optional): 评论图片集合 ,
 children (Array[QuestionCommentModel], optional): 子级评论
 **/
@class FileEntityModel;
@interface HMQuestionCommentModel : NSObject
@property (nonatomic, copy) NSNumber *comment_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) NSArray *children;
@end
