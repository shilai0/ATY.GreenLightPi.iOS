//
//  PersonalCenterViewModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PersonalCenterViewModel.h"
#import "BaseRequest.h"

@implementation PersonalCenterViewModel
- (void)xs_initializesOperating {
    /***********************    获取个人中心用户资料   *************************/
    _GetPersonalCenterUser = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getPersonalCenterSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetPersonalCenterUser params:input success:^(NSDictionary *resultDic) {
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
        return getPersonalCenterSignal;
    }];
    
    /***********************    获取个人中心用户资料教练模型   *************************/
    _GetCoachUser = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getCoachUserSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetCoachUser params:input success:^(NSDictionary *resultDic) {
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
        return getCoachUserSignal;
    }];
    
    /***********************    获取个人中心用户资料绘本作者   *************************/
    _GetBookUser = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getBookUserSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetBookUser params:input success:^(NSDictionary *resultDic) {
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
        return getBookUserSignal;
    }];
    
    /***********************    获取个人中心用户资料文章作者   *************************/
    _GetArticleUser = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getArticleUserSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetArticleUser params:input success:^(NSDictionary *resultDic) {
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
        return getArticleUserSignal;
    }];
    
    /***********************    获取个人中心我的预约   *************************/
    _GetPersonalAppointment = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getPersonalAppointmentSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetPersonalAppointment params:input success:^(NSDictionary *resultDic) {
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
        return getPersonalAppointmentSignal;
    }];
    
    /***********************    个人中心取消预约   *************************/
    _CancelAppointment = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *cancelAppointmentSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_CancelAppointment params:input success:^(NSDictionary *resultDic) {
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
        return cancelAppointmentSignal;
    }];
    
    
    /***********************    个人中心取消预约(基因检测)   *************************/
    _UpdateAppointmentStatus = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *updateAppointmentStatusSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_UpdateAppointmentStatus params:input success:^(NSDictionary *resultDic) {
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
        return updateAppointmentStatusSignal;
    }];
    
    
    /***********************    获取个人中心我的收藏   *************************/
    _GetPersonalCollect = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getPersonalCollectSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetPersonalCollect params:input success:^(NSDictionary *resultDic) {
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
        return getPersonalCollectSignal;
    }];
    
    /***********************    获取个人中心阅读记录   *************************/
    _GetReadRecord = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getReadRecordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetReadRecord params:input success:^(NSDictionary *resultDic) {
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
        return getReadRecordSignal;
    }];
    
    /***********************    删除收藏   *************************/
    _DeleteCollect = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *deleteCollectSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_DeleteCollect params:input success:^(NSDictionary *resultDic) {
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
        return deleteCollectSignal;
    }];
    
    /***********************    删除阅读记录   *************************/
    _DeleteReadRecord = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *deleteCollectSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_DeleteReadRecord params:input success:^(NSDictionary *resultDic) {
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
        return deleteCollectSignal;
    }];
    
    
    /***********************    根据用户编号获取订单记录   *************************/
    _GetOrderRecord = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getOrderRecordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetOrderRecord params:input success:^(NSDictionary *resultDic) {
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
        return getOrderRecordSignal;
    }];
    
    /** 根据用户编号获取已购课程 */
    _GetOrderCourses = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getOrderCoursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetOrderCourses params:input success:^(NSDictionary *resultDic) {
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
        return getOrderCoursesSignal;
    }];
    
    /** 根据用户编号，获取关注的人，及粉丝 */
    _GetFollowAndFans = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getFollowAndFansSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetFollowAndFans params:input success:^(NSDictionary *resultDic) {
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
        return getFollowAndFansSignal;
    }];
    
    /** 根据用户编号，获取积分流水 */
    _GetIntegralForUserId = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getIntegralSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetIntegralForUserId params:input success:^(NSDictionary *resultDic) {
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
        return getIntegralSignal;
    }];
    
    /** 修改个人中心资料 */
    _UpdatePersonal = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *updatePersonalSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_UpdatePersonal params:input success:^(NSDictionary *resultDic) {
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
        return updatePersonalSignal;
    }];
    
    /** 上传头像 */
    _UpdateFile = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *uploadFileSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest UploadWithURL:common_uploadFile params:input[@"params"] imageArr:input[@"imgArr"] success:^(NSDictionary *resultDic) {
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
        return uploadFileSignal;
    }];
    
    /** ai识别身份证 */
    _AiIdcard = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *aiIdcardSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_AiIdcard params:input success:^(NSDictionary *resultDic) {
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
        return aiIdcardSignal;
    }];
    
    /** 获取用户消息 */
    _GetUserMessage = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getUserMessageSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetUserMessage params:input success:^(NSDictionary *resultDic) {
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
        return getUserMessageSignal;
    }];
    
    /** 修改消息状态 */
    _UpdateMessageStatus = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *updateMessageStatusSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_UpdateMessageStatus params:input success:^(NSDictionary *resultDic) {
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
        return updateMessageStatusSignal;
    }];
    
    
    /** 更换手机，旧手机号验证 */
    _ReplacePhoneOneCode = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *replacePhoneOneCodeSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_ReplacePhoneOneCode params:input success:^(NSDictionary *resultDic) {
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
        return replacePhoneOneCodeSignal;
    }];
    
    /** 更换手机，新手机号处理 */
    _ReplacePhoneNew = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *replacePhoneNewSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_ReplacePhoneNew params:input success:^(NSDictionary *resultDic) {
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
        return replacePhoneNewSignal;
    }];
    
    /** 修改密码 */
    _ChangePassword = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *changePasswordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_ChangePassword params:input success:^(NSDictionary *resultDic) {
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
        return changePasswordSignal;
    }];
    
    /** 个人中心反馈留言 */
    _FeedbackMessage = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *feedbackMessageSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_FeedbackMessage params:input success:^(NSDictionary *resultDic) {
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
        return feedbackMessageSignal;
    }];
    
    /** 添加或编辑单个宝宝 */
    _AddOrEditorBaby = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *addOrEditorBabySignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_AddOrEditBaby params:input success:^(NSDictionary *resultDic) {
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
        return addOrEditorBabySignal;
    }];
    
    /** 删除单个宝宝 */
    _DeleteBaby = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *deleteBabySignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_DeleteBaby params:input success:^(NSDictionary *resultDic) {
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
        return deleteBabySignal;
    }];
    
    /** 根据用户编号获取动态（查看普通用户，及查看自己的动 */
    _GetDynamicForUserId = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getDynamicSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetDynamicForUserId params:input success:^(NSDictionary *resultDic) {
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
        return getDynamicSignal;
    }];
    
    /** 删除动态 */
    _DeleteDynamic = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *deleteDynamicSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_DeleteDynamic params:input success:^(NSDictionary *resultDic) {
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
        return deleteDynamicSignal;
    }];
    
    /** 获取推荐用户 */
    _GetSearchRedUser = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getSearchRedUserSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetSearchRedUser params:input success:^(NSDictionary *resultDic) {
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
        return getSearchRedUserSignal;
    }];
    
    /** 获取搜索用户 */
    _GetSearchUser = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getSearchUserSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetSearchUser params:input success:^(NSDictionary *resultDic) {
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
        return getSearchUserSignal;
    }];
    
    /** 关注用户 */
    _ConcernUser = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *concernUserSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_ConcernUser params:input success:^(NSDictionary *resultDic) {
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
        return concernUserSignal;
    }];
    
    /** 取消关注 */
    _CancelConcern = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *cancelConcernSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_CancelConcern params:input success:^(NSDictionary *resultDic) {
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
        return cancelConcernSignal;
    }];
    
    /** 添加宝宝成长记录 */
    _AddBabyPhysiqueRecord = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *addBabyPhysiqueRecordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_AddBabyPhysiqueRecord params:input success:^(NSDictionary *resultDic) {
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
        return addBabyPhysiqueRecordSignal;
    }];
    
    /** 根据用户id 分页获取绘本 */
    _GetBookPage = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getBookPageSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetBookPage params:input success:^(NSDictionary *resultDic) {
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
        return getBookPageSignal;
    }];
  
    /** 根据用户id分页获取文章列表 */
    _GetArticlePage = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getArticlePageSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetArticlePage params:input success:^(NSDictionary *resultDic) {
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
        return getArticlePageSignal;
    }];
    
    /** 根据用户id分页获取教练作品列表 */
    _GetUserCourses = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getUserCoursesSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetUserCourses params:input success:^(NSDictionary *resultDic) {
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
        return getUserCoursesSignal;
    }];
    
    /** 获取签到集合（7天） */
    _GetSignInList = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getSignInListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetSignInList params:input success:^(NSDictionary *resultDic) {
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
        return getSignInListSignal;
    }];
    
    /** 签到 */
    _SignIn = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *signInSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_SignIn params:input success:^(NSDictionary *resultDic) {
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
        return signInSignal;
    }];
    
    /**************** 获取盒子使用时间 *****************/
    _GetBoxUseTime = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getBoxUseTimeSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetBoxUseTime params:input success:^(NSDictionary *resultDic) {
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
        return getBoxUseTimeSignal;
    }];
    
    /****************** 获取盒子提醒时间 *****************/
    _GetBoxTimeRemind = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getBoxTimeRemindSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetBoxTimeRemind params:input success:^(NSDictionary *resultDic) {
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
        return getBoxTimeRemindSignal;
    }];
    
    /****************** 设置盒子使用时间 *****************/
    _SetBoxUseTime = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getBoxUseTimeSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_SetBoxUseTime params:input success:^(NSDictionary *resultDic) {
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
        return getBoxUseTimeSignal;
    }];
    
    
    
    /****************** 设置盒子提醒时间 *****************/
    _SetBoxTimeRemind = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getBoxTimeRemindSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_SetBoxTimeRemind params:input success:^(NSDictionary *resultDic) {
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
        return getBoxTimeRemindSignal;
    }];
    
    /****************** 转移盒子权限 *****************/
    _TransferBox = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *transferBoxSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_TransferBox params:input success:^(NSDictionary *resultDic) {
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
        return transferBoxSignal;
    }];
    
    /****************** App激活盒子 *****************/
    _AppActivityBox = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *appActivityBoxSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_AppActivityBox params:input success:^(NSDictionary *resultDic) {
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
        return appActivityBoxSignal;
    }];
    
    
    /****************** 根据用户编号获取权益中心内容 *****************/
    _GetIncomeCenter = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getIncomeCenterSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetIncomeCenter params:input success:^(NSDictionary *resultDic) {
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
        return getIncomeCenterSignal;
    }];
    
    /****************** 根据收益类型分页获取收益列表 *****************/
    _GetIncomeList = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getIncomeListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetIncomeList params:input success:^(NSDictionary *resultDic) {
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
        return getIncomeListSignal;
    }];
    
    /****************** 根据用户Id分页获取用户团队成员列表 *****************/
    _GetMyTeamForApp = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getMyTeamForAppSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetMyTeamForApp params:input success:^(NSDictionary *resultDic) {
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
        return getMyTeamForAppSignal;
    }];
    
    /** H5分销系统--根据用户Id获取用户银行卡列表 */
    /****************** 根据用户Id分页获取用户团队成员列表 *****************/
    _GetMyBankCard = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getMyBankCardSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetMyBankCard params:input success:^(NSDictionary *resultDic) {
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
        return getMyBankCardSignal;
    }];
    
    
    
    /****************** 添加银行卡 *****************/
    _CreateBankCard = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *ceateBankCardSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_CreateBankCard params:input success:^(NSDictionary *resultDic) {
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
        return ceateBankCardSignal;
    }];
    
    /****************** 申请提现到银行卡 *****************/
    _DrawMoneyToBank = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *drawMoneyToBankSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_DrawMoneyToBank params:input success:^(NSDictionary *resultDic) {
//                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
//                } else {
//                    [subscriber sendNext:nil];
//                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return drawMoneyToBankSignal;
    }];
    
    /****************** 分页获取我的申请提现记录 *****************/
    _GetDrawMoneyRecord = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getDrawMoneyRecordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:PC_GetDrawMoneyRecord params:input success:^(NSDictionary *resultDic) {
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
        return getDrawMoneyRecordSignal;
    }];
    
    /****************** 忘记提现密码--验证提交信息是否正确 *****************/
    _ForgetDrawMoneyPassword = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *forgetDrawMoneyPasswordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:PC_ForgetDrawMoneyPassword params:input success:^(NSDictionary *resultDic) {
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
        return forgetDrawMoneyPasswordSignal;
    }];
}

@end
