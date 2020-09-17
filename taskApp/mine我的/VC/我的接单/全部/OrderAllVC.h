//
//  OrderAllVC.h
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderAllVC : BassMianViewController

/// 列表类型 1全部 2代提交 3审核中 4不合格 5已完成
@property(nonatomic, assign)int type;

-(instancetype)initType:(int) type;

@end

NS_ASSUME_NONNULL_END
