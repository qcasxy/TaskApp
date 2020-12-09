//
//  MineModel.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineModel : NSObject
@property(nonatomic,copy)NSString * account;
@property(nonatomic,copy)NSString * mineID;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * img;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * headimg;
@property(nonatomic,copy)NSString * sex;//性别 1男2女
@property(nonatomic,copy)NSString * level;
@property(nonatomic,copy)NSString * authentic;//是否认证 1是 2否
@property(nonatomic,copy)NSString * brokerage;//佣金
@property(nonatomic,copy)NSString * price;//余额
@property(nonatomic,copy)NSString * invite;//邀请码
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * levelname;
@property(nonatomic,copy)NSString * share;
@property(nonatomic,copy)NSString * poster;
@property(nonatomic,copy)NSString * withdraw;   //  提现成功总合金额 2020-12-07新增字段
@property(nonatomic,copy)NSString * openid;
@end

NS_ASSUME_NONNULL_END
