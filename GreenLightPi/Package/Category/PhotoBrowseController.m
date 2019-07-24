//
//  PhotoBrowseController.m
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "PhotoBrowseController.h"
#import "PhotoBrowseCell.h"
#import "UIView+Layout.h"
#import "PhotoBrowseModel.h"

@interface PhotoBrowseController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

/** collectionView */
@property(nonatomic, strong) UICollectionView *collectionView;
/** 选择按钮 */
@property(nonatomic, strong) UIButton *selectedBtn;
/** 页码 */
@property(nonatomic, strong) UILabel *pageLabel;
/** 模型数组 */
@property(nonatomic, strong) NSMutableArray *photoBrowseModelArr;
/** 当前显示的Index */
@property(nonatomic, assign) NSInteger currentIndex;
/** 当前的image */
@property(nonatomic, strong) UIImage *currentImage;
/** 当前indexPath */
@property(nonatomic, strong) NSIndexPath *currentIndexPath;
/** 进入查看大图的Controller的方式 */
@property(nonatomic, assign) NSInteger way;

@end

static NSString *ID = @"PhotoBrowseCell";

@implementation PhotoBrowseController

- (instancetype)initWithAllPhotosArray:(NSArray *)photosArr currentIndex:(NSInteger)currentIndex way:(NSInteger)way
{
    if (self = [super init])
    {
        self.way = way ;
        
        if (photosArr.count > 0 && [[photosArr firstObject] isKindOfClass:[UIImage class]]) {
            for (UIImage *image in photosArr)
            {
                PhotoBrowseModel *model = [PhotoBrowseModel photoBrowseModelWithImage:image];
                [self.photoBrowseModelArr addObject:model];
            }
        } else {
            for (NSString *url in photosArr)
            {
                PhotoBrowseModel *model = [PhotoBrowseModel photoBrowseModelWithUrl:url];
                [self.photoBrowseModelArr addObject:model];
            }
        }
        
        self.currentIndex = currentIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.selectedBtn];
    [self.view addSubview:self.pageLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    [self.collectionView setContentOffset:CGPointMake((KSCREEN_WIDTH + 20) * self.currentIndex, 0) animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(KSCREEN_WIDTH + 20, KSCREENH_HEIGHT);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, KSCREEN_WIDTH + 20, KSCREENH_HEIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentOffset = CGPointMake(0, 0);
        _collectionView.contentSize = CGSizeMake(self.photoBrowseModelArr.count * (KSCREEN_WIDTH + 20), 0);
        [_collectionView registerClass:[PhotoBrowseCell class] forCellWithReuseIdentifier:ID];
    }
    return _collectionView;
}

- (UIButton *)selectedBtn
{
    if (!_selectedBtn)
    {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedBtn.frame = CGRectMake(KSCREEN_WIDTH - 64, 29, 44, 25);
        [_selectedBtn setImage:[UIImage imageNamed:@"babyalbum_btn_more"] forState:UIControlStateNormal];
        [_selectedBtn addTarget:self action:@selector(clickSelectedBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _selectedBtn;
}

- (UILabel *)pageLabel
{
    if (!_pageLabel)
    {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, KSCREEN_WIDTH, 22)];
        _pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currentIndex + 1, self.photoBrowseModelArr.count];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.font = [UIFont systemFontOfSize:20.0];
        _pageLabel.backgroundColor = [UIColor clearColor];
    }
    return _pageLabel;
}

- (NSMutableArray *)photoBrowseModelArr
{
    if (!_photoBrowseModelArr)
    {
        _photoBrowseModelArr = [NSMutableArray array];
    }
    return _photoBrowseModelArr;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoBrowseModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoBrowseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.model = self.photoBrowseModelArr[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.singleTapGestureBlock = ^(){
        
        if (weakSelf.way == 1) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else {
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
    
    self.currentImage = cell.browseView.imageView.image;
    self.currentIndexPath = indexPath;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PhotoBrowseCell class]])
    {
        [(PhotoBrowseCell *)cell recoverSubviews];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PhotoBrowseCell class]])
    {
        [(PhotoBrowseCell *)cell recoverSubviews];
    }
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //设置页码Label
    NSInteger page = scrollView.contentOffset.x / (KSCREEN_WIDTH + 20);
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", page + 1, self.photoBrowseModelArr.count];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
