//
//  STPickerArea.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerArea.h"

@interface STPickerArea()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.数据源数组 */
@property (nonatomic, strong, nullable) NSArray *arrayRoot;
/** 2.当前省数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayProvince;
/** 3.当前城市数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayCity;
/** 3.当前城市全名数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayFullCity;
/** 4.当前城市code数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayCityCode;

/** 5.当前选中数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arraySelected;

/** 6.省份 */
@property (nonatomic, strong, nullable) NSString *province;
/** 7.城市(比如:杭州市) */
@property (nonatomic, strong, nullable) NSString *city;
/** 7.城市全名(比如:浙江省杭州市) */
@property (nonatomic, strong, nullable) NSString *fullCity;
/** 9.城市code */
@property (nonatomic, strong, nullable) NSNumber *cityCode;
@end

@implementation STPickerArea

#pragma mark - --- init 视图初始化 ---

- (void)setupUI {
    // 1.获取数据
    [self.arrayRoot enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayProvince addObject:obj[@"areaName"]];
    }];

    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.arrayRoot firstObject][@"areas"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayCity addObject:obj[@"areaName"]];
        [self.arrayFullCity addObject:obj[@"fullName"]];
        [self.arrayCityCode addObject:obj[@"areaCode"]];
    }];

    self.province = self.arrayProvince[0];
    self.city = self.arrayCity[0];
    self.fullCity = self.arrayFullCity[0];
    self.cityCode = self.arrayCityCode[0];
    // 2.设置视图的默认属性
    _heightPickerComponent = 32;
    [self setTitle:@"请选择所在地"];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];

}

#pragma mark - --- delegate 视图委托 ---
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.arrayProvince.count;
    } else {
        return self.arrayCity.count;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.arraySelected = self.arrayRoot[row][@"areas"];

        [self.arrayCity removeAllObjects];
        [self.arrayFullCity removeAllObjects];
        [self.arrayCityCode removeAllObjects];
        [self.arraySelected enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.arrayCity addObject:obj[@"areaName"]];
            [self.arrayFullCity addObject:obj[@"fullName"]];
            [self.arrayCityCode addObject:obj[@"areaCode"]];
        }];


        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];

    } else if (component == 1) {
        if (self.arraySelected.count == 0) {
            self.arraySelected = [self.arrayRoot firstObject][@"areas"];
        }
    } else {
        
    }

    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {

    NSString *text;
    if (component == 0) {
        text =  self.arrayProvince[row];
    }else{
        text =  self.arrayCity[row];
    }

    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;


}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk {
    [self.delegate pickerArea:self province:self.province city:self.fullCity area:self.cityCode];
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData {
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    self.province = self.arrayProvince[index0];
    self.city = self.arrayCity[index1];
    self.fullCity = self.arrayFullCity[index1];
    self.cityCode = self.arrayCityCode[index1];
    NSString *title = [NSString stringWithFormat:@"%@",self.city];
    [self setTitle:title];

}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 ---

- (NSArray *)arrayRoot {
    if (!_arrayRoot) {
      _arrayRoot = [ATYUtils requestData:@"areas"];
    }
    return _arrayRoot;
}

- (NSMutableArray *)arrayProvince {
    if (!_arrayProvince) {
        _arrayProvince = [NSMutableArray array];
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity {
    if (!_arrayCity) {
        _arrayCity = [NSMutableArray array];
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayFullCity {
    if (!_arrayFullCity) {
        _arrayFullCity = [[NSMutableArray alloc] init];
    }
    return _arrayFullCity;
}

- (NSMutableArray *)arrayCityCode {
    if (!_arrayCityCode) {
        _arrayCityCode = [NSMutableArray array];
    }
    return _arrayCityCode;
}

- (NSMutableArray *)arraySelected {
    if (!_arraySelected) {
        _arraySelected = [NSMutableArray array];
    }
    return _arraySelected;
}

@end


