//
//  FamilyCoachViewModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FamilyCoachViewModel.h"
#import "BaseRequest.h"

@implementation FamilyCoachViewModel
- (void)xs_initializesOperating {
    
    /***********************   获取课程(居家学院)   *************************/
    _GetHomeCoursesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *coursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetCourses params:input success:^(NSDictionary *resultDic) {
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
        return coursesSignal;
        return [self getCourse:input];
    }];
    
    /***********************   获取课程(情绪魔法师)   *************************/
    _GetMagicianCoursesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *coursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetCourses params:input success:^(NSDictionary *resultDic) {
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
        return coursesSignal;
        return [self getCourse:input];

    }];
    
    /***********************   获取课程(公开课)   *************************/
    _GetOpenClassCoursesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *coursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetCourses params:input success:^(NSDictionary *resultDic) {
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
        return coursesSignal;
        return [self getCourse:input];

    }];
    
    /***********************   获取课程(家园共育八阶段)   *************************/
    _GeteEightStageCoursesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *coursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetCourses params:input success:^(NSDictionary *resultDic) {
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
        return coursesSignal;
        return [self getCourse:input];
        
    }];
    
    /***********************   获取课程(音频)   *************************/
    _GetAudioCoursesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *audioCoursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetCourses params:input success:^(NSDictionary *resultDic) {
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
        return audioCoursesSignal;
        return [self getCourse:input];

    }];
    
    /***********************   根据编号获取课程详细  *************************/
    _GetCoursesForIdCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getCoursesForIdSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetCoursesForId params:input success:^(NSDictionary *resultDic) {
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
        return getCoursesForIdSignal;
    }];
    
    /***********************   根据编号获取课程详细游客  *************************/
    _GetCoursesForIdCommandyk = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getCoursesForIdykSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetCoursesForIdyk params:input success:^(NSDictionary *resultDic) {
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
        return getCoursesForIdykSignal;
    }];
    
    /***********************   根据内容类型获取分类   *************************/
    _GetFcClassifiesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *classifiesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetFcClassifies params:input success:^(NSDictionary *resultDic) {
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
        return classifiesSignal;
    }];
    
    /***********************   下单   *************************/
    _PlaceAnOrderCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *placeAnOrderSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:FC_PlaceAnOrder params:input success:^(NSDictionary *resultDic) {
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
        return placeAnOrderSignal;
    }];
    
    /***********************   评价   *************************/
    _GiveCommentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *giveCommentSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GiveComment params:input success:^(NSDictionary *resultDic) {
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
        return giveCommentSignal;
    }];
    
    /***********************   收藏课程   *************************/
    _CollecCourseCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *collecCourseSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_CollectCourses params:input success:^(NSDictionary *resultDic) {
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
        return collecCourseSignal;
    }];
    
    /***********************   取消收藏课程   *************************/
    _CancelCollecCourseCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *cancelCollecCourseSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_CancelCollectCourses params:input success:^(NSDictionary *resultDic) {
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
        return cancelCollecCourseSignal;
    }];
    
    /***********************   获取轮播图   *************************/
    _GetAdByTypeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getAdByTypeSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetAdByType params:input success:^(NSDictionary *resultDic) {
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
        return getAdByTypeSignal;
    }];
    
    /***********************   获取我的收藏   *************************/
    _GetMyCollectListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getMyCollectListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetMyCollectList params:input success:^(NSDictionary *resultDic) {
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
        return getMyCollectListSignal;
    }];
    
    /***********************   获取阅读记录   *************************/
    _GetWatchRecordListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getWatchRecordListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FC_GetWatchRecordList params:input success:^(NSDictionary *resultDic) {
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
        return getWatchRecordListSignal;
    }];
    
    /***********************   添加阅读记录   *************************/
    _AddFcWatchRecordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *addFcWatchRecordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:FC_AddFcWatchRecord params:input success:^(NSDictionary *resultDic) {
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
        return addFcWatchRecordSignal;
    }];
}

- (RACSignal *)getCourse:(NSMutableDictionary *)input {
    RACSignal *coursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
        [BaseRequest GETRequestDataWithReuestURL:FC_GetCourses params:input success:^(NSDictionary *resultDic) {
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
    return coursesSignal;
}

@end
