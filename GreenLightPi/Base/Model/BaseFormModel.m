//
//  BaseFormModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseFormModel.h"

@implementation BaseFormModel

+ (NSMutableArray *)xs_getDataWithPlist:(NSString *)plist {
    NSString *path = [[NSBundle mainBundle] pathForResource:plist ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    return [self xs_getdataWithArr:arr];
}

+ (NSMutableArray *)xs_getdataWithArr:(NSArray *)arr {
    NSArray *dataArr = [[arr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [BaseFormModel mj_objectWithKeyValues:value];
    }] array];
    return [dataArr mutableCopy];
}

+ (NSArray *)xs_getDicWithModelArr:(NSArray *)dataArr {
    NSArray *dic = [BaseDetailFormModel mj_keyValuesArrayWithObjectArray:dataArr];
    
    return dic;
}

+ (BOOL)setDataWithArr:(NSArray *)dataArr filtrationArr:(NSArray *)arr block:(addBlock) addBlock {
    __block BOOL isJump = NO;
    __block NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    [dataArr enumerateObjectsUsingBlock:^(BaseFormModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id caseArr = arr[idx];
        if ([caseArr isKindOfClass:[NSArray class]]) {
            NSArray *itemArr = arr[idx];
            if(itemArr.count == obj.itemsArr.count){
                [obj.itemsArr enumerateObjectsUsingBlock:^(BaseDetailFormModel *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                    [parmas setObject:obj1.text forKey:itemArr[idx1]];
                    if (!obj1.isEmpty) {
                        if (obj1.text.length <1) {
                            *stop = YES;
                            *stop1 = YES;
                            isJump = YES;
                        }
                    }
                }];
            }
        } else {
            [obj.itemsArr enumerateObjectsUsingBlock:^(BaseDetailFormModel *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                [parmas setObject:obj1.text forKey:arr[idx1]];
                if (!obj1.isEmpty) {
                    if (obj1.text.length <1) {
                        *stop = YES;
                        *stop1 = YES;
                        isJump = YES;
                    }
                }
            }];
        }
    }];
    addBlock(parmas,isJump);
    return isJump;
}

- (void)setItemsArr:(NSMutableArray *)itemsArr {
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dataDic in itemsArr) {
        BaseDetailFormModel *detailModle = [BaseDetailFormModel mj_objectWithKeyValues:dataDic];
        [dataArr addObject:detailModle];
    }
    
    _itemsArr = dataArr;
}

-(id)copyWithZone:(NSZone *)zone
{
    BaseFormModel *sfModel = [[[self class]allocWithZone:zone]init];
    sfModel->_headerTitle = [_headerTitle copy];
    sfModel->_section = _section;
    sfModel->_footerTitle = [_footerTitle copy];
    sfModel->_isShowFooter = _isShowFooter;
    sfModel->_isDelete = _isDelete;
    sfModel->_itemsArr = [[NSMutableArray alloc]initWithArray:_itemsArr copyItems:YES];
    return sfModel;
}

/** 获取底层模型 */
+(BaseDetailFormModel *)xs_getModelWithArr:(NSArray <BaseFormModel *>*)dataArr fromIndexPath:(NSIndexPath *)path{
    BaseFormModel *model = dataArr[path.section];
    return model.itemsArr[path.row];
}
@end

@implementation BaseDetailFormModel

-(id)copyWithZone:(NSZone *)zone
{
    BaseDetailFormModel *sfDetailModel = [[[self class]allocWithZone:zone]init];
    sfDetailModel->_isEdit = _isEdit;
    sfDetailModel->_isShowArrow = _isShowArrow;
    sfDetailModel->_isEmpty = _isEmpty;
    sfDetailModel->_keyBordType = _keyBordType;
    sfDetailModel->_placeholder = [_placeholder copy];
    sfDetailModel->_title = [_title copy];
    sfDetailModel->_text = [_text copy];
    sfDetailModel->_textColor = [_textColor copy];
    sfDetailModel->_isNeed = _isNeed;
    sfDetailModel->_dataArr = [[NSMutableArray alloc] initWithArray:_dataArr copyItems:YES];
    sfDetailModel->_parmas = [_parmas copy];
    return sfDetailModel;
}

@end
