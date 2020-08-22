//
//  MyDIYEmpty.h
//  CheckCoupons
//
//  Created by zhongmao on 2017/12/20.
//  Copyright © 2017年 zhongmao. All rights reserved.
//

#import "LYEmptyView.h"

@interface MyDIYEmpty : LYEmptyView

+ (instancetype)diyNoDataEmpty;

+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action;

+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action;

@end
