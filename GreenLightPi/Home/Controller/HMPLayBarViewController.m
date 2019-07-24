//
//  HMPLayBarViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMPLayBarViewController.h"
#import "FatherStudyContentListModel.h"
#import "HMGameLibraryViewController.h"
#import "FatherStudyCategoryModel.h"
#import "FSDetailViewController.h"
#import "HMPlayBarListView.h"
#import "HMPlayBarHeadView.h"
#import "FileEntityModel.h"
#import "HomeViewModel.h"
#import "HomeModel.h"

@interface HMPLayBarViewController ()
@property (nonatomic, strong) HMPlayBarListView *playBarListView;
@property (nonatomic, strong) HomeViewModel *homeVM;
@end

@implementation HMPLayBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatPlayBarViews];
    [self requestPlayBarData];
}

- (void)creatPlayBarViews {
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];

    [self aty_setCenterNavItemtitle:@"玩吧" titleColor:0x333333];
    
    [self.view addSubview:self.playBarListView];
    
    [self.playBarListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
    }];
    
    self.playBarListView.twoHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        HMGameLibraryViewController *gameLibaryVC = [[HMGameLibraryViewController alloc] init];
        gameLibaryVC.homeModel = self.homeModel;
        gameLibaryVC.gametype = moreGame;
        [self.navigationController pushViewController:gameLibaryVC animated:YES];
    };
    
    self.playBarListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        switch (indexPath.section) {
            case 0:
            case 2:
            {
                FatherStudyContentModel *model = dataArr[indexPath.section][indexPath.row];
                FSDetailViewController *detailVC = [[FSDetailViewController alloc] init];
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],model.content_id];
                } else {
                    detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%@",model.content_id];
                }
                detailVC.aId = model.content_id;
                detailVC.titleStr = model.title;
                detailVC.content = model.summarize;
                detailVC.urlStr = model.image.path;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
                break;
            case 1:
            {
                HMGameLibraryViewController *gameLibaryVC = [[HMGameLibraryViewController alloc] init];
                gameLibaryVC.homeModel = self.homeModel;
                gameLibaryVC.gametype = gameLibrary;
                [self.navigationController pushViewController:gameLibaryVC animated:YES];
            }
                break;
            default:
                break;
        }
    };
}

#pragma mark -- requestData
- (void)requestPlayBarData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"categoryId"] = [NSNumber numberWithInteger:self.homeModel.categoryId];
    params[@"themeId"] = [NSNumber numberWithInteger:0];
    params[@"pageindex"] = [NSNumber numberWithInteger:1];
    params[@"pagesize"] = [NSNumber numberWithInteger:8];
    [[self.homeVM.GetPlayHome execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
            if (model.contentList.count > 3) {
                self.playBarListView.dataArr = [[NSMutableArray alloc] initWithObjects:[NSArray arrayWithObject:[model.contentList firstObject]],[[NSArray alloc] init],[model.contentList subarrayWithRange:NSMakeRange(1, 3)], nil];
            } else {
                self.playBarListView.dataArr = [[NSMutableArray alloc] initWithObjects:[NSArray arrayWithObject:[model.contentList firstObject]],[[NSArray alloc] init],[model.contentList subarrayWithRange:NSMakeRange(1, model.contentList.count - 1)], nil];
            }
            
            [self.playBarListView reloadData];
        }
    }];
    
}

#pragma mark -- 懒加载
- (HMPlayBarListView *)playBarListView {
    if (!_playBarListView) {
        _playBarListView = [[HMPlayBarListView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _playBarListView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

@end
