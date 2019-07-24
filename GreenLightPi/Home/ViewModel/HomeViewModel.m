//
//  HomeViewModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/7.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HomeViewModel.h"
#import "BaseRequest.h"

@implementation HomeViewModel
- (void)xs_initializesOperating {
    
    /*********************** 获取首页模块内容 *************************/
    _getHomeContentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getHomeContentSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetHomeContent params:input success:^(NSDictionary *resultDic) {
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
        return getHomeContentSignal;
    }];
    
    /***********************     获取首页广告弹窗   *************************/
    _getAdByTypeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
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
  
    /******** 根据登录用户id获取宝宝列表 ********/
    _getBabyListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getBabyListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetBabyList params:input success:^(NSDictionary *resultDic) {
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
        return getBabyListSignal;
    }];
    
    /***********************    获取更多阅读列表 themeId传0 某一主题下的所有文章列表 更多阅读 的更多列表   *************************/
    _getContentList = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *contentListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FS_GetContentList params:input success:^(NSDictionary *resultDic) {
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
        return contentListSignal;
    }];
    
    _GetPlayHome = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *contentListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:FS_GetPlayHome params:input success:^(NSDictionary *resultDic) {
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
        return contentListSignal;
    }];
    
    
    /*********************** 绑定宝宝上传宝宝头像 *************************/
    _saveBabyImageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *saveBabyImageSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
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
        return saveBabyImageSignal;
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
    
    /***********************  获取用户所在家庭组集合  **********************/
    _GetFamilyMemberCommand= [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getFamilySignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetFamilyMember params:input success:^(NSDictionary *resultDic) {
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
        return getFamilySignal;
    }];
    
    /***********************  获取用户所在家庭盒子集合  **********************/
    _GetUserBoxListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getUserBoxSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetUserBoxList params:input success:^(NSDictionary *resultDic) {
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
        return getUserBoxSignal;
    }];
    
    /******************  退出家庭  *****************/
    _QuitCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *quitSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:HM_QuitFamily params:input success:^(NSDictionary *resultDic) {
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
        return quitSignal;
    }];
    
    /******************  同意加入家庭组  *****************/
    _InviteFamilyMemberCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *inviteFamilyMemberSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:HM_InviteFamilyMember params:input success:^(NSDictionary *resultDic) {
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
        return inviteFamilyMemberSignal;
    }];
    
    /**********************  玩吧还要玩更多数据  **********************/
    _GetAlsoPlayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getAlsoPlaySignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetAlsoPlay params:input success:^(NSDictionary *resultDic) {
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
        return getAlsoPlaySignal;
    }];
    
    
    
    
    
    
    /*********************** 获取首页所有频道 *************************/
    _getHomeAllChannelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getHomeAllChannelSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetHomeAllChannel params:input success:^(NSDictionary *resultDic) {
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
        return getHomeAllChannelSignal;
    }];
    
    /***********************     获取首页我的频道   *************************/
    _getHomeMyChannelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getHomeMyChannelSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetHomeMyChannel params:input success:^(NSDictionary *resultDic) {
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
        return getHomeMyChannelSignal;
    }];
    
    /***********************     修改首页我的频道   *************************/
    _updateHomeMyChannelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *updateHomeMyChannelSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:HM_UpdateHomeMyChannel params:input success:^(NSDictionary *resultDic) {
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
        return updateHomeMyChannelSignal;
    }];
    
    
    /***********************     获取首页列表数据   *************************/
    _getArticleListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getArticleListSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_GetArticleList params:input success:^(NSDictionary *resultDic) {
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
        return getArticleListSignal;
    }];
    
    /** 获取上传到七牛云的token */
    _getTokenCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getTokenSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:common_getUpToken params:input success:^(NSDictionary *resultDic) {
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
        return getTokenSignal;
    }];
    
    /***********************    我的搜索历史   *************************/
    _getMySearchHistoryCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *mySearchHistorySignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_MySearchHistory params:input success:^(NSDictionary *resultDic) {
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
        return mySearchHistorySignal;
    }];
    
    /***********************    热门搜索   *************************/
    _getHotSearchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *hotSearchSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_HotSearch params:input success:^(NSDictionary *resultDic) {
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
        return hotSearchSignal;
    }];
    
    /***********************   删除我的搜索历史   *************************/
    _deleteSearchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *deleteSearchSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:HM_DeleteSearch params:input success:^(NSDictionary *resultDic) {
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
        return deleteSearchSignal;
    }];
    
    /***********************    搜索全站内容   *************************/
    _getSearchAllCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *searchSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:HM_SearchAll params:input success:^(NSDictionary *resultDic) {
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
        return searchSignal;
    }];
    
    /*********************** 评论文章 *************************/
    _CreateContentCommentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *createContentCommentSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
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
        return createContentCommentSignal;
    }];
    
    /*********************** 收藏文章 *************************/
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
    
}

@end
