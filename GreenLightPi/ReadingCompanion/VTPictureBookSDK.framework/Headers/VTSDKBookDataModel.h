//
//  VTSDKDataModel.h
//  VTPictureBook
//
//  Created by wantong_clover on 2019/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTSDKBookDataModel : NSObject
@property (nonatomic, assign) int bookid;//书本ID
@property (nonatomic, assign) int pageId;//书页id
@property (nonatomic, assign) int pagination;//书页编码
@property (nonatomic, assign) int type;//书页类型
@property (nonatomic, assign) int networkStatus;
@property (nonatomic, assign) int physicalIndex;
@property (nonatomic, strong) NSString *extraData;
@property (nonatomic, strong) NSString *audios;
@property (nonatomic, strong) NSDictionary *bookInfo;
@end

//@interface VTSDKBookInfoDataModel : NSObject
//@property (nonatomic , assign) int bookid;//书本ID
//@property (nonatomic , strong) NSString *bookName;//书本名称
//@end

NS_ASSUME_NONNULL_END
