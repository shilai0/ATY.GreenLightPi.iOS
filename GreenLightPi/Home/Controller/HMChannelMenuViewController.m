//
//  HMChannelMenuViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/8.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMChannelMenuViewController.h"
#import "UIView+JM.h"
#import "ColumnModel.h"
#import "ColumnCell.h"
#import "ColumnHeadView.h"
#import "HomeViewModel.h"

@interface HMChannelMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 导航栏的view */
@property (nonatomic, weak) UIView *menuNavView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *menuDataSource;// 数据源
@property (nonatomic, weak)ColumnHeadView *headViewOne;
@property (nonatomic, weak)ColumnHeadView *headViewTwo;
@property (nonatomic, strong)HomeViewModel *homeVM;
/** 引用headView编辑字符串 */
@property(nonatomic, assign)UIButton *editBtn;
@property(nonatomic, strong)NSMutableArray *otherArrM;
@property(nonatomic, strong)NSMutableArray *allTagsArrM;
@property(nonatomic, assign)BOOL isRefresh;
@end

@implementation HMChannelMenuViewController

- (HomeViewModel *)homeVM {
    if (_homeVM == nil) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

+(HMChannelMenuViewController *)columnMenuViewController:(void(^)(NSString *menuStr))clickMenuCellBlock;
{
    HMChannelMenuViewController *VC = [[HMChannelMenuViewController alloc] init];
    VC.clickMenuCellBlock = clickMenuCellBlock;
    return VC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        if (self.isRefresh) {
            [KNotificationCenter postNotificationName:EDITECHANLE_CONTENT_NOTIFICATION object:nil userInfo:nil];
        }
    }];
    
    [self aty_setCenterNavItemtitle:@"编辑频道" titleColor:0x333333];
    
    //初始化UI
    [self initCustomUI];
    // 配置网络接口数据并刷新
    [self requetData];
    // Do any additional setup after loading the view.
}

- (void)initCustomUI
{

    //视图布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight + 8, self.view.width, self.view.height - KNavgationBarHeight - 8 - KBottomSafeHeight) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ColumnCell" bundle:nil] forCellWithReuseIdentifier:@"ColumnCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ColumnHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ColumnHeadView"];
    //添加手势
    UILongPressGestureRecognizer *longPressRec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressed:)];
    [self.collectionView addGestureRecognizer:longPressRec];
    
}

#pragma mark - 手势识别
- (void)onLongPressed:(UILongPressGestureRecognizer *)sender {
    if (!self.editBtn.selected) {
        [self clickEditBtn];
    }
    
    //获取点击在collectionView的坐标
    CGPoint point = [sender locationInView:sender.view];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath.section == 0 && indexPath.item == 0) {
                return;
            }
            
            if (indexPath) {
                if (@available(iOS 9.0, *)) {
                    [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                } else {
                    // Fallback on earlier versions
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (indexPath.section == 0 && indexPath.item == 0) {
                return;
            }
            
            if (@available(iOS 9.0, *)) {
                if (indexPath.section == 0 && indexPath.item > 3) {
                    [self.collectionView updateInteractiveMovementTargetPosition:point];
                }
            } else {
                // Fallback on earlier versions
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (@available(iOS 9.0, *)) {
                [self.collectionView endInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
            self.isRefresh = YES;
            break;
        }
        default: {
            if (@available(iOS 9.0, *)) {
                [self.collectionView cancelInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
            break;
        }
    }
}

#pragma mark - Req
- (void)requetData
{
    @weakify(self);
    [[self.homeVM.getHomeAllChannelCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            @strongify(self);
            NSDictionary *dataDic = [x[@"Data"] firstObject];
            NSArray *dataArr = dataDic[@"CategoryList"];
            [self.allTagsArrM addObjectsFromArray:dataArr];
                        
            NSMutableArray *myTagsArrN = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.myTagsArrM.count; i ++) {
                [myTagsArrN addObject:self.myTagsArrM[i][@"typename"]];
            }
            
            for (NSDictionary *dic in self.allTagsArrM) {
                if (![myTagsArrN containsObject:dic[@"typename"]]) {
                    [self.otherArrM addObject:dic];
                }
            }
            
            NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.myTagsDefault.count)];
            [self.myTagsArrM insertObjects:self.myTagsDefault atIndexes:indexes];
            for (NSDictionary *dic in self.myTagsArrM) {
                ColumnModel *model = [[ColumnModel alloc] init];
                model.title = dic[@"typename"];
                model.showAdd = NO;
                model.selected = NO;
                if ([model.title isEqualToString:@"推荐"] || [model.title isEqualToString:@"关注"] || [model.title isEqualToString:@"问答"]) {
                    model.resident = YES;
                }
                [self.menuDataSource[0] addObject:model];
            }
            
            for (NSDictionary *dic in self.otherArrM) {
                ColumnModel *model = [[ColumnModel alloc] init];
                model.title = dic[@"typename"];
                model.showAdd = NO;
                model.selected = NO;
                [self.menuDataSource[1] addObject:model];
            }
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark -Lazy
-(NSMutableArray *)menuDataSource
{
    if (!_menuDataSource) {
        _menuDataSource = [NSMutableArray arrayWithObjects:[NSMutableArray array],[NSMutableArray array], nil];
    }
    return _menuDataSource;
}

- (NSMutableArray *)allTagsArrM {
    if (_allTagsArrM == nil) {
        _allTagsArrM = [[NSMutableArray alloc] init];
    }
    return _allTagsArrM;
}

- (NSMutableArray *)otherArrM {
    if (_otherArrM == nil) {
        _otherArrM = [[NSMutableArray alloc] init];
    }
    return _otherArrM;
}

#pragma mark - 导航栏右侧关闭按钮点击事件

- (void)navCloseBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate
//一共有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger sectionNum = 0;
    if ([self.menuDataSource[0] count]) {
        return 2;
    }
    return sectionNum;
}

//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.menuDataSource[0] count];
    } else {
        return [self.menuDataSource[1] count];
    }
}

//每一个cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColumnCell" forIndexPath:indexPath];
    
    NSMutableArray *sectionAry = self.menuDataSource[indexPath.section];
//    __weak typeof(self) weakSelf = self;
    [cell configUIWithData:sectionAry[indexPath.row] indexPath:indexPath closeBtn:^(ColumnModel *model,NSIndexPath *indexpath) {
//        [weakSelf colseBtnClick:model index:indexpath];
    }];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        __weak typeof(self) weakSelf = self;
        
        if (indexPath.section == 0 && _headViewOne)  {
            return _headViewOne;
        }else if (indexPath.section == 1 && _headViewTwo){
            return _headViewTwo;
        }
        ColumnHeadView *headView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ColumnHeadView" forIndexPath:indexPath];
        headView.editBtnBlock = ^() {
            [weakSelf clickEditBtn];
        };
        
        if (indexPath.section == 0) {
            headView.biaotiLab.text = @"已选频道";
            headView.tishiLab.text = @"按住拖动调整排序";
            headView.editBtn.hidden = NO;
            _editBtn = headView.editBtn;
            _headViewOne = headView;
        }else
        {
            headView.biaotiLab.text = @"频道推荐";
            headView.tishiLab.text = @"点击添加频道";
            headView.editBtn.hidden = YES;
            _headViewTwo = headView;
        }
        
        return headView;
    }else
    {
        return nil;
    }
    
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

//头部视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.width, 40);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(0, 0);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.collectionView.width - 50)/4, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ColumnModel *model;
    if (indexPath.section == 0) {
        model = self.menuDataSource[0][indexPath.item];
        //判断是否为编辑状态
        if (!_headViewOne.editBtn.selected) { // 非编辑状态直接会上一级,返回title
            if (self.clickMenuCellBlock) {
                self.clickMenuCellBlock(model.title);
            }
            [self navCloseBtnClick];
        }else
        {
            //编辑状态
            if (model.resident) { // 不可删除
                return;
            }
            [self colseBtnClick:model index:indexPath];
            
        }
    }else
    {
        model = self.menuDataSource[1][indexPath.item];
        [self colseBtnClick:model index:indexPath];
    }
}

//在开始移动是调动此代理方法
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"开始移动");
    return YES;
}

//在移动结束的时候调用此代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 取出数据源
    ColumnModel *model;
    if (sourceIndexPath.section == 0) {
        model = self.menuDataSource[0][sourceIndexPath.item];
        [self.menuDataSource[0] removeObjectAtIndex:sourceIndexPath.item];
    } else {
        model = self.menuDataSource[1][sourceIndexPath.item];
        [self.menuDataSource[1] removeObjectAtIndex:sourceIndexPath.item];
    }
    
    if (destinationIndexPath.section == 0) {
        model.selected = YES;
        model.showAdd = NO;
        [self.menuDataSource[0] insertObject:model atIndex:destinationIndexPath.item];
    } else  if (destinationIndexPath.section == 1) {
        model.selected = NO;
        model.showAdd = NO;
        [self.menuDataSource[1] insertObject:model atIndex:destinationIndexPath.item];
    }
    
    [collectionView reloadItemsAtIndexPaths:@[destinationIndexPath]];
    
}

#pragma mark -Action
//点击事件
- (void)colseBtnClick:(ColumnModel *)model index:(NSIndexPath *)indexPath;
{
    self.isRefresh = YES;
    if (indexPath.section == 0) {
        @weakify(self);
        [self.myTagsArrM enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            NSString *titleName = obj[@"typename"];
            if ([titleName isEqualToString:model.title]) {
                [self.myTagsArrM removeObject:obj];
                [self.otherArrM addObject:obj];
            }
        }];
        
    } else {
        @weakify(self);
        [self.otherArrM enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            NSString *titleName = obj[@"typename"];
            if ([titleName isEqualToString:model.title]) {
                [self.myTagsArrM addObject:obj];
                [self.otherArrM removeObject:obj];
            }
        }];
        
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"user_id"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] init];
    [self.myTagsArrM removeObjectsInArray:self.myTagsDefault];
    paramsDic[@"CategoryList"] = self.myTagsArrM;
    paramsDic[@"Type"] = @"article";
    NSMutableArray *paramsArr = [[NSMutableArray alloc] init];
    [paramsArr addObject:paramsDic];
    params[@"channelList"] = paramsArr;
    
    @weakify(self);
    [[self.homeVM.updateHomeMyChannelCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if (indexPath.section == 0) {
                model.selected = NO;
                model.showAdd = NO;
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                NSIndexPath *targetIndexPage = [NSIndexPath indexPathForItem:0 inSection:1];
                [self.menuDataSource[0] removeObject:model];
                [self.menuDataSource[1] insertObject:model atIndex:0];
                    [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPage];
            } else {
                model.showAdd = NO;
                model.selected = self.headViewOne.editBtn.selected;
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                NSIndexPath *targetIndexPage = [NSIndexPath indexPathForItem:[self.menuDataSource[0] count] inSection:0];
                [self.menuDataSource[1] removeObjectAtIndex:indexPath.item];
                [self.menuDataSource[0] addObject:model];
                [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPage];
            }
            [self.collectionView reloadData];
        }
    }];
}

// 点击编辑按钮
- (void)clickEditBtn
{
    _headViewOne.editBtn.selected = !_headViewOne.editBtn.selected;
    for (ColumnModel *model in self.menuDataSource[0]) {
        if (model.resident) {
            continue;
        }
        model.selected = _headViewOne.editBtn.selected;
    }
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
