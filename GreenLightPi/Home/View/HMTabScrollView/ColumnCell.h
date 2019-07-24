//
//  ColumnCell.h
//  columnManager
//
//  Created by toro宇 on 2018/6/4.
//  Copyright © 2018年 yijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnModel.h"
@interface ColumnCell : UICollectionViewCell
@property (nonatomic, strong)void(^closeBtnBlock)(ColumnModel *model,NSIndexPath *indexpath);

-(void)configUIWithData:(ColumnModel *)model indexPath:(NSIndexPath *)indexPath closeBtn:(void(^)(ColumnModel *model,NSIndexPath *indexpath))closeBtnBlock;

@end
