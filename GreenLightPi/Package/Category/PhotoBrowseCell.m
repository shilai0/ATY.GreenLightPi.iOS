//
//  PhotoBrowseCell.m
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "PhotoBrowseCell.h"
#import "UIView+Layout.h"
#import "PhotoBrowseModel.h"
#import "UIImageView+WebCache.h"

@implementation PhotoBrowseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor blackColor];
        self.browseView = [[PhotoBrowseView alloc] initWithFrame:self.bounds];
        
        __weak typeof(self) weakSelf = self;
        self.browseView.singleTapGestureBlock = ^(){
            if (weakSelf.singleTapGestureBlock) {
                weakSelf.singleTapGestureBlock();
            }
        };
        
        [self addSubview:self.browseView];
    }
    return self;
}

- (void)setModel:(PhotoBrowseModel *)model
{
    self.browseView.model = model;
}

- (void)recoverSubviews
{
    [self.browseView recoverSubviews];
}


@end


@interface PhotoBrowseView() <UIScrollViewDelegate>

@end

@implementation PhotoBrowseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.frame = CGRectMake(10, 0, self.pf_width - 20, self.pf_height);
        self.scrollView.bouncesZoom = YES;
        self.scrollView.maximumZoomScale = 2.5;
        self.scrollView.minimumZoomScale = 1.0;
        self.scrollView.multipleTouchEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.delaysContentTouches = NO;
        self.scrollView.canCancelContentTouches = YES;
        self.scrollView.alwaysBounceVertical = NO;
        [self addSubview:self.scrollView];
        
        self.imageContainerView = [[UIView alloc] init];
        self.imageContainerView.clipsToBounds = YES;
        self.imageContainerView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:self.imageContainerView];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.imageContainerView addSubview:self.imageView];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tap2.numberOfTapsRequired = 2;
        [tap1 requireGestureRecognizerToFail:tap2];
        [self addGestureRecognizer:tap2];
    }
    return self;
}

- (void)setModel:(PhotoBrowseModel *)model
{
    _model = model;
    if (_model.URL) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.URL]];
    } else {
        self.imageView.image = _model.image;
    }
}

- (void)recoverSubviews
{
    [self.scrollView setZoomScale:1.0 animated:NO];
    [self resizeSubviews];
}

- (void)resizeSubviews
{
    self.imageContainerView.pf_origin = CGPointZero;
    self.imageContainerView.pf_width = self.scrollView.pf_width;
    
    UIImage *image = self.imageView.image;
    if (image.size.height / image.size.width > self.pf_height / self.scrollView.pf_width)
    {
        self.imageContainerView.pf_height = floor(image.size.height / (image.size.width / self.scrollView.pf_width));
    }
    else
    {
        CGFloat height = image.size.height / image.size.width * self.scrollView.pf_width;
        if (height < 1 || isnan(height)) height = self.pf_height;
        height = floor(height);
        self.imageContainerView.pf_height = height;
        self.imageContainerView.centerY = self.pf_height / 2;
    }
    if (self.imageContainerView.pf_height > self.pf_height && self.imageContainerView.pf_height - self.pf_height <= 1)
    {
        self.imageContainerView.pf_height = self.pf_height;
    }
    CGFloat contentSizeH = MAX(self.imageContainerView.pf_height, self.pf_height);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.pf_width, contentSizeH);
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    self.scrollView.alwaysBounceVertical = self.imageContainerView.pf_height <= self.pf_height ? NO : YES;
    self.imageView.frame = _imageContainerView.bounds;
    
    [self refreshScrollViewContentSize];
}

#pragma mark - UITapGestureRecognizer Event

- (void)doubleTap:(UITapGestureRecognizer *)tap
{
    if (self.scrollView.zoomScale > 1.0)
    {
        self.scrollView.contentInset = UIEdgeInsetsZero;
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
    else
    {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)tap
{
    if (self.singleTapGestureBlock)
    {
        self.singleTapGestureBlock();
    }
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageContainerView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self refreshImageContainerViewCenter];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [self refreshScrollViewContentSize];
}

#pragma mark - Private

- (void)refreshImageContainerViewCenter
{
    CGFloat offsetX = (self.scrollView.pf_width > self.scrollView.contentSize.width) ? ((self.scrollView.pf_width - self.scrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (self.scrollView.pf_height > self.scrollView.contentSize.height) ? ((self.scrollView.pf_height - self.scrollView.contentSize.height) * 0.5) : 0.0;
    self.imageContainerView.center = CGPointMake(self.scrollView.contentSize.width * 0.5 + offsetX, self.scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)refreshScrollViewContentSize
{
    self.scrollView.contentInset = UIEdgeInsetsZero;
}

@end
