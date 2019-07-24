//
//  PhotoBrowseModel.h
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoBrowseModel : NSObject

/** 照片url */
@property(nonatomic, copy) NSString *URL;

/** 照片image */
@property(nonatomic, strong) UIImage *image;

+ (instancetype)photoBrowseModelWithUrl:(NSString *)url;

+ (instancetype)photoBrowseModelWithImage:(UIImage *)image;

@end
