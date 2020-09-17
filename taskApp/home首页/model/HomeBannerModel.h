//
//  HomeBannerModel.h
//  taskApp
//
//  Created by 秦程 on 2020/9/15.
//  Copyright © 2020 per. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeBannerModel : NSObject

@property (nonatomic, copy) NSString *cover;
/// 跳转类型，1代表显示内容  2代表跳转链接
@property (nonatomic, assign) NSInteger type;
/// 显示的内容，为富文本框内容
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
