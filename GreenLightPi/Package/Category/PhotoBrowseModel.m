//
//  PhotoBrowseModel.m
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "PhotoBrowseModel.h"

@implementation PhotoBrowseModel

+ (instancetype)photoBrowseModelWithUrl:(NSString *)url
{
    PhotoBrowseModel *model = [[self alloc] init];
    
    model.URL = url ;
    
    return model;
}

+ (instancetype)photoBrowseModelWithImage:(UIImage *)image {
    PhotoBrowseModel *model = [[self alloc] init];
    
    model.image = image ;
    
    return model;
}

@end
