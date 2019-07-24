//
//  DetailCommonViewModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "DetailCommonViewModel.h"
#import "BaseRequest.h"

@implementation DetailCommonViewModel

- (void)xs_initializesOperating {
    /***********************    获取首页问答详情   *************************/
    _getDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *detailtSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_Detail params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return detailtSignal;
    }];

    /***********************    评论文章   *************************/
    _CreateContentCommentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *contentCommentSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:common_CreateContentComment params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return contentCommentSignal;
    }];
    
    /***********************    转发文章   *************************/
    _TranspondQuestionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *transpondQuestionSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:common_TranspondQuestion params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return transpondQuestionSignal;
    }];
    
    /***********************    收藏文章   *************************/
    _CollectArticleCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *collectArticleSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:common_CollectArticle params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return collectArticleSignal;
    }];
    
    /***********************  点赞/取消点赞文章 *************************/
    _LikeArticleCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *likeArticleSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:common_LikeArticle params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return likeArticleSignal;
    }];
}

@end
